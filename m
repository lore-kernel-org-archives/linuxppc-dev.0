Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEE852BF10
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 03:54:14 +1100 (EST)
In-Reply-To: <313680C9A886D511A06000204840E1CF0A6473A1@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF0A6473A1@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EB2FC607-4EB9-11D9-9515-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 15 Dec 2004 11:54:00 -0500
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: I2C + Linux 2.6 on MPC880/MPC885 based board(s)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 15, 2004, at 11:04 AM, Povolotsky, Alexander wrote:

> Firstly, I have a (hardware related) question: - how I2C is supported 
> on
> MPC880/MPC885 basede boards
> and for what purposes/functions it (I2C) is typically used there ?

If you read the archives :-)  .......

Anyway, the one thing you need to be careful about is the overhead
of using the CPM I2C.  If you are sending/receiving large messages
on the I2C, it's probably useful to use the CPM.  If you are only 
sending
a few bytes, the over head of set up/interrupt/clean up is substantial.

Normally, I just use the I2C pins as GPIO and use the bit-bang
algorithm.  It's a trivial interface to configure for any board, gets
you going to more important things.

Otherwise, it looks like someone that has an interest in
using the CPM I2C (which isn't me) will need to port it first to 2.6,
then provide the board specific functions for set up and control.

On top of this, if you want to run the SMBus protocols, you will
need a much more complex CPM I2C functions.



	-- Dan
