Return-Path: <namhyung@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 312D51A0661
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 00:00:58 +1000 (AEST)
Received: by pdbki1 with SMTP id ki1so16476426pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 07:00:56 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date: Wed, 27 May 2015 22:59:28 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] perf: Add power8 PMU events in JSON format
Message-ID: <20150527135928.GB29557@danjae.kornet>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-5-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1432080130-6678-5-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 19, 2015 at 05:02:10PM -0700, Sukadev Bhattiprolu wrote:
> The power8.json and 004d0100.json files describe the PMU events in the
> Power8 processor.
> 
> The jevents program from the prior patches will use these JSON files
> to create tables which will then be used in perf to build aliases for
> PMU events. This in turn would allow users to specify these PMU events
> by name:
> 
> 	$ perf stat -e pm_1plus_ppc_cmpl sleep 1
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---

[SNIP]
> +  {
> +    "EventCode": "0x2505e",
> +    "EventName": "PM_BACK_BR_CMPL",
> +    "BriefDescription": "Branch instruction completed with a target address less than current instruction address,",
> +    "PublicDescription": "Branch instruction completed with a target address less than current instruction address.,"

Can't we remove PublicDescription field if it's identical to
BriefDescription?  It seems just wasting spaces..

Thanks,
Namhyung


> +  },
> +  {
> +    "EventCode": "0x4082",
> +    "EventName": "PM_BANK_CONFLICT",
> +    "BriefDescription": "Read blocked due to interleave conflict. The ifar logic will detect an interleave conflict and kill the data that was read that cycle.,",
> +    "PublicDescription": "Read blocked due to interleave conflict. The ifar logic will detect an interleave conflict and kill the data that was read that cycle.,"
> +  },
> +  {
> +    "EventCode": "0x10068",
> +    "EventName": "PM_BRU_FIN",
> +    "BriefDescription": "Branch Instruction Finished,",
> +    "PublicDescription": "Branch Instruction Finished .,"
> +  },
> +  {
> +    "EventCode": "0x20036",
> +    "EventName": "PM_BR_2PATH",
> +    "BriefDescription": "two path branch,",
> +    "PublicDescription": "two path branch.,"
> +  },
> +  {
> +    "EventCode": "0x5086",
> +    "EventName": "PM_BR_BC_8",
> +    "BriefDescription": "Pairable BC+8 branch that has not been converted to a Resolve Finished in the BRU pipeline,",
> +    "PublicDescription": "Pairable BC+8 branch that has not been converted to a Resolve Finished in the BRU pipeline,"
> +  },
> +  {
> +    "EventCode": "0x5084",
> +    "EventName": "PM_BR_BC_8_CONV",
> +    "BriefDescription": "Pairable BC+8 branch that was converted to a Resolve Finished in the BRU pipeline.,",
> +    "PublicDescription": "Pairable BC+8 branch that was converted to a Resolve Finished in the BRU pipeline.,"
> +  },
