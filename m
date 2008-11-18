Return-Path: <timur.tabi@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 9DC63DDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 11:56:42 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1081308ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 16:56:41 -0800 (PST)
Message-ID: <ed82fe3e0811171656g5b214c5eqe64b26b8310524f7@mail.gmail.com>
Date: Mon, 17 Nov 2008 18:56:41 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: Some udbg questions
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm adding udbg support to my console driver, and I've noticed that
there is not much consistency on how the various platforms implement
udbg support.  So I have a few questions:

1. What is the point of implementing udbg_getc?  What does the console
do with any characters it receives this early?
2. In my driver's udbg initialization function, should I be able to
parse the device tree to get parameters?
3. What about command-line parameters?
4. The LPAR and PMAC platforms call register_early_udbg_console (in
the udbg_init_debug_lpar and pmac_init_early functions, respectively),
but none of the other platforms do.  It appears that the other
platforms rely on setup_32.c and setup_64.c to call this function.
What's so special about LPAR and PMAC?
5. Some platforms (like mv64x60) use the ppc_md.init_early function to
initialize the early console.  Others update function
udbg_early_init() in udbg.c instead.  Why do some platforms do it one
way, and other platforms do it the other way?  Which way is preferred?

-- 
Timur Tabi
Linux kernel developer at Freescale
