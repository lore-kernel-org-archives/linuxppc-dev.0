Return-Path: <anton@samba.org>
Date: Fri, 17 Jun 2011 15:26:02 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/3] powerpc: POWER7 optimised copy_page using VMX
Message-ID: <20110617152602.131dd709@kryten>
In-Reply-To: <27834.1308287767@neuling.org>
References: <20110617045358.544896830@samba.org>
	<20110617045421.538184870@samba.org> <27834.1308287767@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> Yeah, I'm pretty against CPU_FTR_POWER7.  Every loon is going to
> attach anything POWER7 to it.  
> 
> I'm keen to see it setup in  __setup_cpu_power7.  Either a function
> pointer or use the patch_instruction infrastructure to avoid indirect
> function calls on small copies.  

Instruction patching in __setup_cpu_power7 could work. We might want to
have a nop at the start of the base functions and a label at the start
of the next instruction so we can easily override the base function and
jump back to it if things are too hard (like I do in the
copy_tofrom_user patch).

Anton
