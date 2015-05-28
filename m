Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 332C21A11B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 22:06:41 +1000 (AEST)
Date: Thu, 28 May 2015 14:06:33 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] jevents: Program to convert JSON file to C style
 file
Message-ID: <20150528120633.GF12392@krava.redhat.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432761809-4344-3-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1432761809-4344-3-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 27, 2015 at 02:23:21PM -0700, Sukadev Bhattiprolu wrote:

SNIP

>  
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> new file mode 100644
> index 0000000..7e0c85c
> --- /dev/null
> +++ b/tools/perf/pmu-events/Build
> @@ -0,0 +1,10 @@
> +jevents-y	+= json.o jsmn.o jevents.o
> +pmu-events-y	+= pmu-events.o
> +JSON		=  $(shell find pmu-events/arch/$(ARCH) -name '*.json')

you might want to check if there's the directory first,
or if there's a way to tell find to be quiet or ignore that

find: ‘pmu-events/arch/x86’: No such file or directory
  CC       pmu-events/json.o
  CC       pmu-events/jsmn.o
  CC       pmu-events/jevents.o
  LD       pmu-events/jevents-in.o
  LINK     pmu-events/jevents
find: ‘pmu-events/arch/x86’: No such file or directory
pmu-events/jevents: Error walking file tree pmu-events/arch/x86
Creating empty pmu_events_map[] table
  CC       pmu-events/pmu-events.o


jirka
