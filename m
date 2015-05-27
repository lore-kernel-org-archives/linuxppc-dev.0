Return-Path: <namhyung@gmail.com>
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B16711A0E35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 23:55:30 +1000 (AEST)
Received: by pdea3 with SMTP id a3so16131485pde.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 06:55:28 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date: Wed, 27 May 2015 22:54:02 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150527135402.GA29557@danjae.kornet>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sukadev,

On Tue, May 19, 2015 at 05:02:08PM -0700, Sukadev Bhattiprolu wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> This is a modified version of an earlier patch by Andi Kleen.
> 
> We expect architectures to describe the performance monitoring events
> for each CPU in a corresponding JSON file, which look like:
> 
> 	[
> 	{
> 	"EventCode": "0x00",
> 	"UMask": "0x01",
> 	"EventName": "INST_RETIRED.ANY",
> 	"BriefDescription": "Instructions retired from execution.",
> 	"PublicDescription": "Instructions retired from execution.",
> 	"Counter": "Fixed counter 1",
> 	"CounterHTOff": "Fixed counter 1",
> 	"SampleAfterValue": "2000003",
> 	"SampleAfterValue": "2000003",
> 	"MSRIndex": "0",
> 	"MSRValue": "0",
> 	"TakenAlone": "0",
> 	"CounterMask": "0",
> 	"Invert": "0",
> 	"AnyThread": "0",
> 	"EdgeDetect": "0",
> 	"PEBS": "0",
> 	"PRECISE_STORE": "0",
> 	"Errata": "null",
> 	"Offcore": "0"
> 	}
> 	]
> 
> We also expect the architectures to provide a mapping between individual
> CPUs to their JSON files. Eg:
> 
> 	GenuineIntel-6-1E,V1,/NHM-EP/NehalemEP_core_V1.json,core
> 
> which maps each CPU, identified by [vendor, family, model, version, type]
> to a JSON file.
> 
> Given these files, the program, jevents::
> 	- locates all JSON files for the architecture,
> 	- parses each JSON file and generates a C-style "PMU-events table"
> 	  (pmu-events.c)
> 	- locates a mapfile for the architecture
> 	- builds a global table, mapping each model of CPU to the
> 	  corresponding PMU-events table.

So we build tables of all models in the architecture, and choose
matching one when compiling perf, right?  Can't we do that when
building the tables?  IOW, why don't we check the VFM and discard
non-matching tables?  Those non-matching tables are also needed?

Sorry if I missed something..


> 
> The 'pmu-events.c' is generated when building perf and added to libperf.a.
> The global table pmu_events_map[] table in this pmu-events.c will be used
> in perf in a follow-on patch.
> 
> If the architecture does not have any JSON files or there is an error in
> processing them, an empty mapping file is created. This would allow the
> build of perf to proceed even if we are not able to provide aliases for
> events.
> 
> The parser for JSON files allows parsing Intel style JSON event files. This
> allows to use an Intel event list directly with perf. The Intel event lists
> can be quite large and are too big to store in unswappable kernel memory.
> 
> The conversion from JSON to C-style is straight forward.  The parser knows
> (very little) Intel specific information, and can be easily extended to
> handle fields for other CPUs.
> 
> The parser code is partially shared with an independent parsing library,
> which is 2-clause BSD licenced. To avoid any conflicts I marked those
> files as BSD licenced too. As part of perf they become GPLv2.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> v2: Address review feedback. Rename option to --event-files
> v3: Add JSON example
> v4: Update manpages.
> v5: Don't remove dot in fixname. Fix compile error. Add include
> 	protection. Comment realloc.
> v6: Include debug/util.h
> v7: (Sukadev Bhattiprolu)
> 	Rebase to 4.0 and fix some conflicts.
> v8: (Sukadev Bhattiprolu)
> 	Move jevents.[hc] to tools/perf/pmu-events/
> 	Rewrite to locate and process arch specific JSON and "map" files;
> 	and generate a C file.
> 	(Removed acked-by Namhyung Kim due to modest changes to patch)
> 	Compile the generated pmu-events.c and add the pmu-events.o to
> 	libperf.a
> ---

[SNIP]
> +/* Call func with each event in the json file */
> +int json_events(const char *fn,
> +	  int (*func)(void *data, char *name, char *event, char *desc),
> +	  void *data)
> +{
> +	int err = -EIO;
> +	size_t size;
> +	jsmntok_t *tokens, *tok;
> +	int i, j, len;
> +	char *map;
> +
> +	if (!fn)
> +		return -ENOENT;
> +
> +	tokens = parse_json(fn, &map, &size, &len);
> +	if (!tokens)
> +		return -EIO;
> +	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
> +	tok = tokens + 1;
> +	for (i = 0; i < tokens->size; i++) {
> +		char *event = NULL, *desc = NULL, *name = NULL;
> +		struct msrmap *msr = NULL;
> +		jsmntok_t *msrval = NULL;
> +		jsmntok_t *precise = NULL;
> +		jsmntok_t *obj = tok++;
> +
> +		EXPECT(obj->type == JSMN_OBJECT, obj, "expected object");
> +		for (j = 0; j < obj->size; j += 2) {
> +			jsmntok_t *field, *val;
> +			int nz;
> +
> +			field = tok + j;
> +			EXPECT(field->type == JSMN_STRING, tok + j,
> +			       "Expected field name");
> +			val = tok + j + 1;
> +			EXPECT(val->type == JSMN_STRING, tok + j + 1,
> +			       "Expected string value");
> +
> +			nz = !json_streq(map, val, "0");
> +			if (match_field(map, field, nz, &event, val)) {
> +				/* ok */
> +			} else if (json_streq(map, field, "EventName")) {
> +				addfield(map, &name, "", "", val);
> +			} else if (json_streq(map, field, "BriefDescription")) {
> +				addfield(map, &desc, "", "", val);
> +				fixdesc(desc);
> +			} else if (json_streq(map, field, "PEBS") && nz) {
> +				precise = val;
> +			} else if (json_streq(map, field, "MSRIndex") && nz) {
> +				msr = lookup_msr(map, val);
> +			} else if (json_streq(map, field, "MSRValue")) {
> +				msrval = val;
> +			} else if (json_streq(map, field, "Errata") &&
> +				   !json_streq(map, val, "null")) {
> +				addfield(map, &desc, ". ",
> +					" Spec update: ", val);
> +			} else if (json_streq(map, field, "Data_LA") && nz) {
> +				addfield(map, &desc, ". ",
> +					" Supports address when precise",
> +					NULL);
> +			}

Wouldn't it be better split arch-specific fields and put them in
somewhere in arch directory?

> +			/* ignore unknown fields */
> +		}
> +		if (precise && !strstr(desc, "(Precise Event)")) {
> +			if (json_streq(map, precise, "2"))
> +				addfield(map, &desc, " ", "(Must be precise)",
> +						NULL);
> +			else
> +				addfield(map, &desc, " ",
> +						"(Precise event)", NULL);
> +		}
> +		if (msr != NULL)
> +			addfield(map, &event, ",", msr->pname, msrval);
> +		fixname(name);
> +		err = func(data, name, event, desc);
> +		free(event);
> +		free(desc);
> +		free(name);
> +		if (err)
> +			break;
> +		tok += j;
> +	}
> +	EXPECT(tok - tokens == len, tok, "unexpected objects at end");
> +	err = 0;
> +out_free:
> +	free_json(map, size, tokens);
> +	return err;
> +}

[SNIP]
> +static int process_mapfile(FILE *outfp, char *fpath)
> +{
> +	int n = 16384;
> +	FILE *mapfp;
> +	char *save;
> +	char *line, *p;
> +	int line_num;
> +	char *tblname;
> +
> +	printf("Processing mapfile %s\n", fpath);
> +
> +	line = malloc(n);
> +	if (!line)
> +		return -1;
> +
> +	mapfp = fopen(fpath, "r");
> +	if (!mapfp) {
> +		printf("Error %s opening %s\n", strerror(errno), fpath);
> +		return -1;
> +	}
> +
> +	print_mapping_table_prefix(outfp);
> +
> +	line_num = 0;
> +	while (1) {
> +		char *vfm, *version, *type, *fname;
> +
> +		line_num++;
> +		p = fgets(line, n, mapfp);
> +		if (!p)
> +			break;
> +
> +		if (line[0] == '#')
> +			continue;
> +
> +		if (line[strlen(line)-1] != '\n') {
> +			/* TODO Deal with lines longer than 16K */
> +			printf("Mapfile %s: line %d too long, aborting\n",
> +					fpath, line_num);
> +			return -1;
> +		}
> +		line[strlen(line)-1] = '\0';
> +
> +		vfm = strtok_r(p, ",", &save);
> +		version = strtok_r(NULL, ",", &save);
> +		fname = strtok_r(NULL, ",", &save);
> +		type = strtok_r(NULL, ",", &save);
> +
> +		tblname = file_name_to_table_name(fname);
> +		fprintf(outfp, "{\n");
> +		fprintf(outfp, "\t.vfm = \"%s\",\n", vfm);
> +		fprintf(outfp, "\t.version = \"%s\",\n", version);
> +		fprintf(outfp, "\t.type = \"%s\",\n", type);
> +
> +		/*
> +		 * CHECK: We can't use the type (eg "core") field in the
> +		 * table name. For us to do that, we need to somehow tweak
> +		 * the other caller of file_name_to_table(), process_json()
> +		 * to determine the type. process_json() file has no way
> +		 * of knowing these are "core" events unless file name has
> +		 * core in it. If filename has core in it, we can safely
> +		 * ignore the type field here also.
> +		 */
> +		fprintf(outfp, "\t.table = %s\n", tblname);
> +		fprintf(outfp, "},\n");
> +	}
> +
> +	print_mapping_table_suffix(outfp);
> +

You need to free 'line' for each return path..

Thanks,
Namhyung


> +	return 0;
> +}
