Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A8656B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 11:03:16 +1000 (EST)
Message-Id: <13B0CDE8-B974-4CFA-A4B9-8AC4374B4694@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: srikanth krishnakar <skrishnakar@gmail.com>
In-Reply-To: <6213bc560907220932u3b771af2q743ae55dda5a2198@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [LTP] msgctl10 fails on Powerpc Linux-2.6.29.6
Date: Wed, 22 Jul 2009 20:03:06 -0500
References: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
	<2A0DDADE-5C3C-43F2-9487-98A8A735DC8D@kernel.crashing.org>
	<6213bc560907220838h49e5c273qa543e538bb37923a@mail.gmail.com>
	<578FBC09-589D-4691-82FF-985FCFE8ADC9@kernel.crashing.org>
	<6213bc560907220932u3b771af2q743ae55dda5a2198@mail.gmail.com>
Cc: Linuxppc-dev@ozlabs.org, Ltp-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 22, 2009, at 11:32 AM, srikanth krishnakar wrote:

>
>
> On Wed, Jul 22, 2009 at 9:14 PM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>
> On Jul 22, 2009, at 10:38 AM, srikanth krishnakar wrote:
>
>
>
> On Wed, Jul 22, 2009 at 8:52 PM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
> I'm not seeing any BUG* in traps.c @ line 904.
>
>
> On Jul 21, 2009, at 4:33 AM, srikanth krishnakar wrote:
>
> The LTP test case msgctl10.c fails on linux-2.6.29.6 for PowerPC  
> architecture (ppc440)
>
>
> msgctl10    1  B------------[ cut here ]------------
> kernel BUG at arch/powerpc/kernel/traps.c:904!
> Oops: Exception in kernel mode, sig: 5 [#9]
>
> I'm not seeing any BUG* in traps.c @ line 904.  Do you have some  
> other patches on top of 2.6.29.6?
>
> - k
>
>
> I have LTTng patches on top of linux-2.6.29.6.
>
> Does it modify traps.c?  Can you see what the code around line 904  
> looks like and post that.
>
> - k
>  896
>  897 #if defined(CONFIG_XILINX_VIRTEX_5_FXT) &&  
> defined(CONFIG_PPC_FPU)
>  898         if (reason & REASON_ILLEGAL) {
>  899                 if (excep_state < 1) {
>  900                         excep_state++;
>  901                         return;
>  902                 }
>  903                 /* should never get here */
>  904                 BUG();
>  905         }
>  906 #endif
>  907
>  908         /* Try to emulate it if we should. */
>

Are you sure this is coming from the LTTng patches?  Which actual  
patch makes this change?

- k
