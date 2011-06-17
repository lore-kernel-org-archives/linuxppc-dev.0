Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] powerpc: POWER7 optimised copy_page using VMX
In-reply-to: <20110617045421.538184870@samba.org>
References: <20110617045358.544896830@samba.org>
	<20110617045421.538184870@samba.org>
Date: Fri, 17 Jun 2011 15:16:07 +1000
Message-ID: <27834.1308287767@neuling.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Implement a POWER7 optimised copy_page using VMX. We copy a cacheline
> at a time using VMX loads and stores.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> How do we want to handle per machine optimised functions? I create
> yet another feature bit, but feature bits might get out of control
> at some point.

Yeah, I'm pretty against CPU_FTR_POWER7.  Every loon is going to attach
anything POWER7 to it.  

I'm keen to see it setup in  __setup_cpu_power7.  Either a function
pointer or use the patch_instruction infrastructure to avoid indirect
function calls on small copies.  

Mikey
