Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 0AE99B6EFE
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 02:44:24 +1000 (EST)
Received: from mail171-tx2 (localhost.localdomain [127.0.0.1])	by
	mail171-tx2-R.bigfish.com (Postfix) with ESMTP id 909034184C9	for
	<linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 16:29:15 +0000 (UTC)
Received: from TX2EHSMHS032.bigfish.com (unknown [10.9.14.242])	by
	mail171-tx2.bigfish.com (Postfix) with ESMTP id 9B25E270052	for
	<linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 16:29:14 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6RGSuaQ005170	for <linuxppc-dev@ozlabs.org>;
	Tue, 27 Jul 2010 09:29:06 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6RGT1jE025794	for <linuxppc-dev@ozlabs.org>;
	Tue, 27 Jul 2010 11:29:01 -0500 (CDT)
Date: Tue, 27 Jul 2010 11:28:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull my perf.git urgent branch
Message-ID: <20100727112854.7bf97d48@schlenkerla.am.freescale.net>
In-Reply-To: <20100727124019.GB14947@brick.ozlabs.ibm.com>
References: <20100727124019.GB14947@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Peter Zijlstra <peterz@infradead.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 27 Jul 2010 22:40:19 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Please do a pull from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulus/perf.git urgent
> 
> to get one commit that fixes a problem where, on some Freescale
> embedded PowerPC machines, unprivileged userspace could oops the
> kernel using the perf_event subsystem.  I know it's late, but it is a
> potential security hole (but only on Freescale embedded systems), the
> fix is small (3 lines) and only affects Freescale embedded processors,
> and I was on vacation for the past two weeks. :)
[snip]
> diff --git a/arch/powerpc/kernel/perf_event_fsl_emb.c b/arch/powerpc/kernel/perf_event_fsl_emb.c
> index 369872f..babccee 100644
> --- a/arch/powerpc/kernel/perf_event_fsl_emb.c
> +++ b/arch/powerpc/kernel/perf_event_fsl_emb.c
> @@ -566,9 +566,9 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>  	 * Finally record data if requested.
>  	 */
>  	if (record) {
> -		struct perf_sample_data data = {
> -			.period	= event->hw.last_period,
> -		};
> +		struct perf_sample_data data;
> +
> +		perf_sample_data_init(&data, 0);
>  
>  		if (perf_event_overflow(event, nmi, &data, regs)) {
>  			/*

Doesn't the setting of .period need to be maintained (it is in the other
powerpc perf_event implementation that this is derived from)?

I don't see how this is a security fix -- the existing initializer above
should zero-fill the fields that are not explicitly initialized.  In fact,
it's taking other fields that were previously initialized to zero and is
making them uninitialized, since perf_sample_data_init only sets addr and
raw.

CCing linuxppc-dev on the original patch would have been nice...

-Scott
