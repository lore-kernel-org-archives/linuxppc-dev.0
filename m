Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D637DED60
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 04:52:57 +1000 (EST)
In-Reply-To: <a901b49a0707180000g1c107323ub6c95a6ef3b5b2fe@mail.gmail.com>
References: <11847405503115-git-send-email-afleming@freescale.com>
	<a901b49a0707180000g1c107323ub6c95a6ef3b5b2fe@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7318E17E-C9F9-42CE-89A4-E3DBAF0A02C6@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 1/2] Fix error checking in Vitesse IRQ config
Date: Wed, 18 Jul 2007 13:52:52 -0500
To: pradeep singh <pradeep.rautela@gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2007, at 02:00, pradeep singh wrote:

> On 7/18/07, Andy Fleming <afleming@freescale.com> wrote:

>> -               if (err)
>> +               if (err < 0)
>>                         return err;
>
> but would that mean, if phy_read returns > 0 it is a success?

Yes.  phy_read() returns a 32-bit value.  If there's an error, it  
returns a negative number.  If not, it returns whatever was in the  
register (which is only 16 bits)

phy_write() returns 0 on success, and non-zero, otherwise.  In  
hindsight, it would have been better to be consistent.

Andy
