Return-Path: <ruchika.k@servergy.com>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
 [209.85.223.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5466E2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 11:48:49 +1100 (EST)
Received: by mail-ie0-f177.google.com with SMTP id tp5so2625724ieb.36
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Dec 2013 16:48:45 -0800 (PST)
Received: from [10.0.0.5] (pool-71-164-229-51.dllstx.fios.verizon.net.
 [71.164.229.51])
 by mx.google.com with ESMTPSA id u1sm615677ige.1.2013.12.06.16.48.44
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 06 Dec 2013 16:48:44 -0800 (PST)
Message-ID: <52A2706A.7030205@servergy.com>
Date: Fri, 06 Dec 2013 18:48:42 -0600
From: Ruchika <ruchika.k@servergy.com>
MIME-Version: 1.0
CC: linuxppc-dev@lists.ozlabs.org
Subject: questions: second of the 2 pcie controllers does not scan the bus.
References: <Pine.LNX.4.64.1311041649250.4290@digraph.polyomino.org.uk>
 <Pine.LNX.4.64.1311041651390.4290@digraph.polyomino.org.uk>
 <1385159644.1403.532.camel@snotra.buserror.net>
 <Pine.LNX.4.64.1311230053360.12354@digraph.polyomino.org.uk>
 <1386376365.7375.209.camel@snotra.buserror.net>
In-Reply-To: <1386376365.7375.209.camel@snotra.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,
I am working with an p4080 based board. I am trying to get 2 PCIE 
controllers probed properly.

In uboot I have no problems scanning and discovering what is connected 
to both controllers/PCI bridges.

For both PCIE1/2 uboot sets up the Primary, secondary and Subordinate 
bus numbers to 0,1,1 respectively.

When linux boots up and probes the controllers, PCIE1 is probed and the 
bridge scanned properly but PCIE2 is probed at the bridge but not 
attempted a scan.
I see this message
"pci 0001:02:00.0: bridge configuration invalid ([bus 01-01]), reconfiguring
"

I updated uboot to set the secondary and subordinate numbers to 2 (left 
the primary number to 0) and a subsequent kernel boot scanned the bus 
for PCIE2 successfully.
I found these numbers to be very critical since the device tree blob 
(bus-range) for pci is also based off these.

I'd like to get a good fix rather than the uboot hack and get better 
understanding of the problem. If there are any pointers someone could 
provide it would be awesome.

Thank you
Regards
Ruchika
