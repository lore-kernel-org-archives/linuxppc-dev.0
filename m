Return-Path: <ivo.schenk@delphin.de>
Received: from smtp.delphin.de (smtp.delphin.de [194.25.251.243])
	by ozlabs.org (Postfix) with ESMTP id 30D6DB70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 02:39:58 +1100 (EST)
From: "Ivo Schenk" <ivo.schenk@delphin.de>
To: <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 18 Oct 2010 17:22:39 +0200
Subject: RE: Parsing DTS file
Message-ID: <633E34A20E0A3F44B9BF69425312C56B131EDA3CBD@exchangesrv1.aeolus.local>
References: <201010181413.58302.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201010181413.58302.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain;
	charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Hello all,
>I'm sure there's a standard way of doing this: I'd like to access some =
info=20
>from the DTS file from a usermode program (things like address of =
device,=20
>etc...)
>What is the best way to do this ? Write a parser ? Or query the running =
kernel=20
>somehow ?

Compile your kernel with CONFIG_PROC_DEVICETREE, then you can access all =
entries via filesystem:

[root@t:~] # ll /proc/device-tree/

-r--r--r--  1 root root  4 Oct 18 17:17 #address-cells
-r--r--r--  1 root root  4 Oct 18 17:17 #size-cells
dr-xr-xr-x  2 root root  0 Oct 18 17:17 chosen
-r--r--r--  1 root root 13 Oct 18 17:17 compatible
dr-xr-xr-x  3 root root  0 Oct 18 17:17 cpus
-r--r--r--  1 root root 13 Oct 18 17:17 dtb-revision
-r--r--r--  1 root root  4 Oct 18 17:17 interrupt-parent
dr-xr-xr-x  8 root root  0 Oct 18 17:17 localbus
dr-xr-xr-x  2 root root  0 Oct 18 17:17 memory
-r--r--r--  1 root root  5 Oct 18 17:17 model
-r--r--r--  1 root root  1 Oct 18 17:17 name
dr-xr-xr-x  2 root root  0 Oct 18 17:17 pci@f0000d00
-r--r--r--  1 root root  9 Oct 18 17:17 serialno
dr-xr-xr-x 32 root root  0 Oct 18 17:17 soc5200@f0000000

--=20
Ivo Schenk
http://www.delphin.de/

Delphin Technology AG
Sitz der Gesellschaft: Bergisch Gladbach
Registergericht: Amtsgericht Koeln, HRB 47544
Vorstand: Ursula Renner (Vorsitzende), Frank Ringsdorf
Vorsitzender des Aufsichtsrats: Peter Renner
