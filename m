Return-Path: <jimix@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D5AF67B14
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 23:23:45 +1000 (EST)
In-Reply-To: <20060518035734.2B2CA67A6D@ozlabs.org>
References: <20060518035734.2B2CA67A6D@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7AC7793A-74F3-4596-BF28-19BCA9E388CF@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] dtc: add setting of physical boot cpu
Date: Thu, 18 May 2006 09:23:24 -0400
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Michael, a few questions:
How does this interact with "linux,boot-cpu"?
If -b is defined then the absence of "linux,boot-cpu" should no  
longer cause a warning.
Perhaps if -b is missing the header value is set from "linux,boot- 
cpu" property?
Should we extend the "linux,boot-cpu" to actually contain a thread-id  
or are we deprecating this prop?
-JX
On May 17, 2006, at 11:56 PM, Michael Neuling wrote:

> dtc always sets the physical boot CPU to 0xfeedbeef.  Add a -b  
> option to
> set this.
>
> ---
> I've tested the blob output but not asm output.
>
> ---
>  dtc.c      |   12 +++++++++---
>  dtc.h      |    6 ++++--
>  flattree.c |   16 ++++++++++------
>  3 files changed, 23 insertions(+), 11 deletions(-)
>
> Index: dtc/dtc.c
> ===================================================================
> --- dtc.orig/dtc.c
> +++ dtc/dtc.c
> @@ -95,6 +95,8 @@ static void usage(void)
>  	fprintf(stderr, "\t\tBlob version to produce, defaults to 3  
> (relevant for dtb\n\t\tand asm output only)\n");
>  	fprintf(stderr, "\t-R <number>\n");
>  	fprintf(stderr, "\t\tMake space for <number> reserve map entries  
> (relevant for \n\t\tdtb and asm output only)\n");
> +	fprintf(stderr, "\t-b <number>\n");
> +	fprintf(stderr, "\t\tSet the physical boot cpu\n");
>  	fprintf(stderr, "\t-f\n");
>  	fprintf(stderr, "\t\tForce - try to produce output even if the  
> input tree has errors\n");
>  	exit(2);
> @@ -113,8 +115,9 @@ int main(int argc, char *argv[])
>  	FILE *outf = NULL;
>  	int outversion = 3;
>  	int reservenum = 1;
> +	int boot_cpuid_phys = 0xfeedbeef;
>
> -	while ((opt = getopt(argc, argv, "I:O:o:V:R:f")) != EOF) {
> +	while ((opt = getopt(argc, argv, "I:O:o:V:R:fb:")) != EOF) {
>  		switch (opt) {
>  		case 'I':
>  			inform = optarg;
> @@ -134,6 +137,9 @@ int main(int argc, char *argv[])
>  		case 'f':
>  			force = 1;
>  			break;
> +		case 'b':
> +			boot_cpuid_phys = strtol(optarg, NULL, 0);
> +			break;
>  		default:
>  			usage();
>  		}
> @@ -185,9 +191,9 @@ int main(int argc, char *argv[])
>  	if (streq(outform, "dts")) {
>  		dt_to_source(outf, bi);
>  	} else if (streq(outform, "dtb")) {
> -		dt_to_blob(outf, bi, outversion);
> +		dt_to_blob(outf, bi, outversion, boot_cpuid_phys);
>  	} else if (streq(outform, "asm")) {
> -		dt_to_asm(outf, bi, outversion);
> +		dt_to_asm(outf, bi, outversion, boot_cpuid_phys);
>  	} else if (streq(outform, "null")) {
>  		/* do nothing */
>  	} else {
> Index: dtc/dtc.h
> ===================================================================
> --- dtc.orig/dtc.h
> +++ dtc/dtc.h
> @@ -207,8 +207,10 @@ struct boot_info *build_boot_info(struct
>
>  /* Flattened trees */
>
> -void dt_to_blob(FILE *f, struct boot_info *bi, int version);
> -void dt_to_asm(FILE *f, struct boot_info *bi, int version);
> +void dt_to_blob(FILE *f, struct boot_info *bi, int version,
> +		int boot_cpuid_phys);
> +void dt_to_asm(FILE *f, struct boot_info *bi, int version,
> +	       int boot_cpuid_phys);
>
>  struct boot_info *dt_from_blob(FILE *f);
>
> Index: dtc/flattree.c
> ===================================================================
> --- dtc.orig/flattree.c
> +++ dtc/flattree.c
> @@ -301,7 +301,8 @@ static struct data flatten_reserve_list(
>  }
>  static void make_bph(struct boot_param_header *bph,
>  		     struct version_info *vi,
> -		     int reservesize, int dtsize, int strsize)
> +		     int reservesize, int dtsize, int strsize,
> +		     int boot_cpuid_phys)
>  {
>  	int reserve_off;
>
> @@ -324,12 +325,13 @@ static void make_bph(struct boot_param_h
>  				     + dtsize + strsize);
>  		
>  	if (vi->flags & FTF_BOOTCPUID)
> -		bph->boot_cpuid_phys = 0xfeedbeef;
> +		bph->boot_cpuid_phys = cpu_to_be32(boot_cpuid_phys);
>  	if (vi->flags & FTF_STRTABSIZE)
>  		bph->size_dt_strings = cpu_to_be32(strsize);
>  }
>
> -void dt_to_blob(FILE *f, struct boot_info *bi, int version)
> +void dt_to_blob(FILE *f, struct boot_info *bi, int version,
> +		int boot_cpuid_phys)
>  {
>  	struct version_info *vi = NULL;
>  	int i;
> @@ -355,7 +357,8 @@ void dt_to_blob(FILE *f, struct boot_inf
>  	reservebuf = flatten_reserve_list(bi->reservelist, vi);
>
>  	/* Make header */
> -	make_bph(&bph, vi, reservebuf.len, dtbuf.len, strbuf.len);
> +	make_bph(&bph, vi, reservebuf.len, dtbuf.len, strbuf.len,
> +		 boot_cpuid_phys);
>
>  	fwrite(&bph, vi->hdr_size, 1, f);
>
> @@ -395,7 +398,7 @@ static void dump_stringtable_asm(FILE *f
>  	}
>  }
>
> -void dt_to_asm(FILE *f, struct boot_info *bi, int version)
> +void dt_to_asm(FILE *f, struct boot_info *bi, int version, int  
> boot_cpuid_phys)
>  {
>  	struct version_info *vi = NULL;
>  	int i;
> @@ -434,7 +437,8 @@ void dt_to_asm(FILE *f, struct boot_info
>  		vi->last_comp_version);
>
>  	if (vi->flags & FTF_BOOTCPUID)
> -		fprintf(f, "\t.long\t0xdeadbeef\t/*boot_cpuid_phys*/\n");
> +		fprintf(f, "\t.long\t%i\t/*boot_cpuid_phys*/\n",
> +			boot_cpuid_phys);
>
>  	if (vi->flags & FTF_STRTABSIZE)
>  		fprintf(f, "\t.long\t_%s_strings_end - _%s_strings_start\t/*  
> size_dt_strings */\n",
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
