Return-Path: <rric.net@gmail.com>
Received: from mail-we0-x231.google.com (mail-we0-x231.google.com
 [IPv6:2a00:1450:400c:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 689B01A0E39
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 05:20:23 +1100 (AEDT)
Received: by mail-we0-f177.google.com with SMTP id l61so22997913wev.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 10:20:18 -0800 (PST)
Sender: Robert Richter <rric.net@gmail.com>
Date: Wed, 21 Jan 2015 19:20:15 +0100
From: Robert Richter <rric@kernel.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2] oprofile: Add HAVE_OPROFILE_NMI_TIMER
Message-ID: <20150121182015.GA4201@rric.localhost>
References: <1421811983-22788-1-git-send-email-anton@samba.org>
 <20150121225408.33194932@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150121225408.33194932@kryten>
Cc: x86@kernel.org, mingo@redhat.com, paulus@samba.org, hpa@zytor.com,
 oprofile-list@lists.sf.net, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.01.15 22:54:08, Anton Blanchard wrote:
> HAVE_PERF_EVENTS_NMI is used for two things - the oprofile NMI timer
> and the hard lockup detector.
> 
> Create HAVE_OPROFILE_NMI_TIMER so an architecture can select them
> separately. On ppc64 we want to add the hard lockup detector, but not
> the oprofile NMI timer fallback.

No, this option should depend on HAVE_PERF_EVENTS_NMI. It uses a perf
counter internally, so if perf supports some sort of 'soft' nmi,
oprofile nmi timer would also work well with it.

I also don't see a reason, why you don't want to support oprofile NMI
timer. Is there any?

> @@ -30,9 +30,12 @@ config OPROFILE_EVENT_MULTIPLEX

>  config OPROFILE_NMI_TIMER
>  	def_bool y
> -	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> +	depends on PERF_EVENTS && HAVE_OPROFILE_NMI_TIMER

I understand that you might want to disable NMI_TIMER, though I really
don't see a reason if oprofile is enabled and can support it.

If you don't want NMI_TIMER being enabled, then (order of preference):

 * disable it with oprofile (OPROFILE dependency needed for
   NMI_TIMER), or

 * make the default value for NMI_TIMER !PPC64 and add a prompt to let
   the user select/deselect it, or

 * disable OPROFILE_NMI_TIMER by adding a !PPC64 dependency.

-Robert
