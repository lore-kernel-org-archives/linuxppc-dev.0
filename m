Return-Path: <kryn@in2p3.fr>
Received: from ccimap.in2p3.fr (ccimap.in2p3.fr [134.158.69.6])
	by ozlabs.org (Postfix) with ESMTP id 6987ADDE25
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Mar 2007 19:56:38 +1000 (EST)
Message-ID: <460A3BBC.5060002@in2p3.fr>
Date: Wed, 28 Mar 2007 11:56:12 +0200
From: Didier Kryn <kryn@in2p3.fr>
MIME-Version: 1.0
To: Konstantin Boyanov <kkboyanov@gmail.com>
Subject: Re: Reading and writing from/to VME device
References: <821B2170E9E7F04FA38DF7EC21DE4871088C81DA@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE4871088C81DA@VCAEXCH01.hq.corp.viasat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Konstantin, I am a little confused;

    You tell you want to access CR/CSR space but you configure your 
window for A24. Even if addresses are coded in 24-bit in CR/CSR, this is 
not the same space as A24. Although I never still used it, I believe 
that CR/CSR is a geographical address space (base address of the board 
defined by its location in the crate) while all others are logical 
address spaces where the base address is set at power up from a 
switch... and can be changed by writing the proper register in  CR/CSR. 
CR/CSR has address modifier 2F, while you are configuring your window 
for A24/data/supervisory which gives address modifier 3D. BTW, most 
boards don't care about user or supervisory, they would respond as well 
to address modifier 39

    To answer one of your questions, for sure inbound windows are 
dedicated to configure the response of the module as a slave and 
outbound windows as a master.

    When you are reading anything else than FF, then you are actually 
reading something, which means that some slave module has accepted the 
transaction. You always get all bits set to 1 in case of VMEbus timeout.

    Hope this helps
    Didier
