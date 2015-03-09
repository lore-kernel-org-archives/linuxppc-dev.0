Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 474141A0CAE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 02:13:49 +1100 (AEDT)
Date: Mon, 9 Mar 2015 15:13:19 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 4/5] mm: split ET_DYN ASLR from mmap ASLR
Message-ID: <20150309151319.GP8656@n2100.arm.linux.org.uk>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-5-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425341988-1599-5-git-send-email-keescook@chromium.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Yann Droneaud <ydroneaud@opteya.com>, linux-s390@vger.kernel.org,
 Andrey Ryabinin <a.ryabinin@samsung.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Borislav Petkov <bp@suse.de>, Ben Hutchings <ben@decadent.org.uk>,
 Will Deacon <will.deacon@arm.com>, linux-fsdevel@vger.kernel.org,
 Alex Smith <alex@alex-smith.me.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@amacapital.net>,
 Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 02, 2015 at 04:19:47PM -0800, Kees Cook wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 248d99cabaa8..e2f0ef9c6ee3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1,7 +1,6 @@
>  config ARM
>  	bool
>  	default y
> -	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST

This doesn't mean much on its own...

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
