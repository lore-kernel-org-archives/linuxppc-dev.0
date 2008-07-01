Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0254ADDF5D
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 17:16:02 +1000 (EST)
Subject: Re: [PATCH] powerpc: fixup lwsync at runtime
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1214893402.20711.104.camel@pasglop>
References: <Pine.LNX.4.64.0807010031241.23830@blarg.am.freescale.net>
	<1214893402.20711.104.camel@pasglop>
Content-Type: text/plain
Date: Tue, 01 Jul 2008 17:15:55 +1000
Message-Id: <1214896555.20711.112.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-01 at 16:23 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2008-07-01 at 00:32 -0500, Kumar Gala wrote:
> > To allow for a single kernel image on e500 v1/v2/mc we need to fixup lwsync
> > at runtime.  On e500v1/v2 lwsync causes an illop so we need to patch up
> > the code.  We default to 'sync' since that is always safe and if the cpu
> > is capable we will replace 'sync' with 'lwsync'.
> > 
> > We introduce CPU_FTR_LWSYNC as a way to determine at runtime if this is
> > needed.  This flag could be moved elsewhere since we dont really use it
> > for the normal CPU_FTR purpose.
> > 
> > Finally we only store the relative offset in the fixup section to keep it
> > as small as possible rather than using a full fixup_entry.
> > 
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> 
> I'd rather have some more generic "alternatives" stuff but in the
> meantime, Ack.

Hrm... minus mpe's comments...

Cheers,
Ben.
