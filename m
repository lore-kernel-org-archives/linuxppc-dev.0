Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8DEA2C02C9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 11:51:47 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 30 Jun 2013 02:51:43 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4833C38C8047
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2013 21:51:39 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5U1pelS313996
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2013 21:51:40 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5U1pc57020718
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2013 22:51:39 -0300
Date: Sun, 30 Jun 2013 09:51:37 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: Avoid overriding MSI interrupt
Message-ID: <20130630015137.GA7919@shangw.(null)>
References: <1372425030-5759-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372547360.18612.76.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372547360.18612.76.camel@pasglop>
Cc: Yuanquan.Chen@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, Guenter Roeck <linux@roeck-us.net>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 30, 2013 at 09:09:20AM +1000, Benjamin Herrenschmidt wrote:
>On Fri, 2013-06-28 at 21:10 +0800, Gavin Shan wrote:

.../...

>I'm running some tests, so far it looks good. However, Gavin, when you
>have a chance on vpl3, try injecting errors to other adapters, for
>example the VGA adapter (you need to do lspci to trigger the EEH
>detection after that since there's no driver and use the "loc code"
>variant off errinjct) or eth2 (the cxgb3).
>
>All I get from EEH with these is:
>
>[  362.962564] EEH: Detected PCI bus error on PHB#7-PE#10000
>[  362.962570] eeh_handle_event: Cannot find PCI bus for PHB#7-PE#10000
>
>and
>
>[  424.381083] EEH: Detected PCI bus error on PHB#6-PE#10000
>[  424.381089] eeh_handle_event: Cannot find PCI bus for PHB#6-PE#10000
>
>Followed by ... nothing.
>

Ben, I think one patch was lost from mainline and that fixes the problem.

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=5fb621698e94e3af8b413d9439041fde48e2784d

I had the patch applied to /home/benh/linux-test and have following commands
to inject errors, everything looks good :-)

errinjct eeh -v -f 0 -p U78AB.001.WZSGBJ6-P1-C5-T1 -a 0x0 -m 0x0
errinjct eeh -v -f 0 -p U78AB.001.WZSGBJ6-P1-C6-T1 -a 0x0 -m 0x0

Thanks,
Gavin
