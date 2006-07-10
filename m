Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 80087679F0
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 06:49:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Date: Mon, 10 Jul 2006 22:49:49 +0200
References: <20060622225609.GA4877@w-mikek2.ibm.com>
	<20060710203510.GA30793@w-mikek2.ibm.com>
In-Reply-To: <20060710203510.GA30793@w-mikek2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607102249.50630.arnd@arndb.de>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 10 July 2006 22:35, Mike Kravetz wrote:
> On Thu, Jun 22, 2006 at 03:56:09PM -0700, Mike Kravetz wrote:
> > This version addresses all comments received except Arnd's issue
> > with an #ifdef for each function in the assembly file.
> 
> I was thinking of changing the names of all the assembly routines from
> plpar_hcall_*() to plpar_hcall_*_asm().  The instrumented version of the
> routines would be named plpar_hcall_*_inst().  Then, the header file
> would contain definitions such as:
> 
> #ifdef CONFIG_HCALL_STATS
> #define plpar_hcall_*()		plpar_hcall_*_inst()
> .
> #else
> #define plpar_hcall_*()		plpar_hcall_*_asm()
> .
> #endif
> 
> Is that any better than all the individual #ifdefs in the .S file?  Is it
> still too ugly?
> 

I guess it's better to have the #ifdef in the header file, but then
again, you could just as well save some source lines doing

#ifndef CONFIG_HCALL_STATS
#define plpar_hcalldef(x) plpar_call_ ## x ## _asm
#else
#define plpar_hcalldef(x) plpar_call_ ## x ## _inst
#endif

#define plpar_call_foo plpar_hcalldef(foo)

	Arnd <><
