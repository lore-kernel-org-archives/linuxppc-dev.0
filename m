Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 94F5AB6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 01:06:49 +1100 (EST)
Message-ID: <1332252387.18960.424.camel@twins>
Subject: Re: [PATCH 04/20] powerpc/mm/fault.c: Port OOM changes to
 do_page_fault
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Kautuk Consul <consul.kautuk@gmail.com>
Date: Tue, 20 Mar 2012 15:06:27 +0100
In-Reply-To: <1332249595-2678-1-git-send-email-consul.kautuk@gmail.com>
References: <1332249595-2678-1-git-send-email-consul.kautuk@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
 Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>,
 Paul Mackerras <paulus@samba.org>, "Mohd. Faris" <mohdfarisq2010@gmail.com>,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-03-20 at 09:19 -0400, Kautuk Consul wrote:
> +#ifd#ifdef CONFIG_PPC_SMLPAR
> +                       if (firmware_has_feature(FW_FEATURE_CMO)) {
> +                               preempt_disable();
> +                               get_lppaca()->page_ins +=3D (1 << PAGE_FA=
CTOR);
> +                               preempt_enable();
> +                       }
> +#end#endif=20

That's curious CPP usage....
