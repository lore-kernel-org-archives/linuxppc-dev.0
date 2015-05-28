Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 482D01A11B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 22:09:25 +1000 (AEST)
Date: Thu, 28 May 2015 14:09:18 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] jevents: Program to convert JSON file to C style
 file
Message-ID: <20150528120918.GG12392@krava.redhat.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432761809-4344-3-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
>  $(PERF_IN): $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h FORCE
>  	$(Q)$(MAKE) $(build)=perf
>  
> -$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN)
> -	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(PERF_IN) $(LIBS) -o $@
> +$(JEVENTS_IN): FORCE
> +	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=jevents
> +
> +$(JEVENTS): $(JEVENTS_IN)
> +	$(QUIET_LINK)$(CC) $(JEVENTS_IN) -o $@
> +
> +$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
> +
> +$(PMU_EVENTS_IN): $(JEVENTS) FORCE
> +	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events

nit.. please move this above perf target, so it's grouped
with the rest of the jevents stuff

jirka

>  
>  $(GTK_IN): FORCE
>  	$(Q)$(MAKE) $(build)=gtk
> @@ -306,6 +321,8 @@ perf.spec $(SCRIPTS) \
>  ifneq ($(OUTPUT),)
>  %.o: $(OUTPUT)%.o
>  	@echo "    # Redirected target $@ => $(OUTPUT)$@"
> +pmu-events/%.o: $(OUTPUT)pmu-events/%.o
> +	@echo "    # Redirected target $@ => $(OUTPUT)$@"
>  util/%.o: $(OUTPUT)util/%.o
>  	@echo "    # Redirected target $@ => $(OUTPUT)$@"
>  bench/%.o: $(OUTPUT)bench/%.o


SNIP
