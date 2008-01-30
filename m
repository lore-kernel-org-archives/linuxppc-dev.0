Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 65A07DE015
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 06:52:30 +1100 (EST)
Message-ID: <47A0D57C.1000104@pikatech.com>
Date: Wed, 30 Jan 2008 14:52:28 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: ndfc ecc byte order
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There seems to be a byte order conflict between the u-boot and Linux 
ndfc drivers.

u-boot has the following:

    /* The NDFC uses Smart Media (SMC) bytes order*/
    ecc_code[0] = p[2];
    ecc_code[1] = p[1];
    ecc_code[2] = p[3];

the kernel has:

    ecc_code[0] = p[1];
    ecc_code[1] = p[2];
    ecc_code[2] = p[3];

I think u-boot has it right since u-boot and kernel software calculated 
ECCs agree. Anybody know a reason *not* to switch to the SMC byte order?

Note that the kernel version will work if you are reading/writing from 
the kernel since they agree on the wrong ECC :p

Cheers,
   Sean
