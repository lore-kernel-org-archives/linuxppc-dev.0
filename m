Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 11CBE140088
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Mar 2014 04:09:04 +1100 (EST)
Received: by mail-la0-f41.google.com with SMTP id gl10so3926032lab.14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 10:08:59 -0700 (PDT)
Message-ID: <5335BABE.80007@cogentembedded.com>
Date: Fri, 28 Mar 2014 21:09:02 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] phy/at8031: enable at8031 to work on interrupt mode
References: <1395901116-16034-1-git-send-email-B45475@freescale.com>
 <53341101.9000404@cogentembedded.com>
 <0ca1e7910cd247c4aebe4cbd48a633cb@BLUPR03MB341.namprd03.prod.outlook.com>
In-Reply-To: <0ca1e7910cd247c4aebe4cbd48a633cb@BLUPR03MB341.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "mugunthanvnm@ti.com" <mugunthanvnm@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "helmut.schaa@googlemail.com" <helmut.schaa@googlemail.com>,
 "zonque@gmail.com" <zonque@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>, Xiaobo Xie <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 03/28/2014 10:36 AM, qiang.zhao@freescale.com wrote:

>>> The at8031 can work on polling mode and interrupt mode.
>>> Add ack_interrupt and config intr funcs to enable interrupt mode for
>>> it.

>>> Signed-off-by: Zhao Qiang <B45475@freescale.com>
>>> ---
>>>    drivers/net/phy/at803x.c | 30 ++++++++++++++++++++++++++++++
>>>    1 file changed, 30 insertions(+)

>>> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c index
>>> bc71947..d034ef5 100644
>>> --- a/drivers/net/phy/at803x.c
>>> +++ b/drivers/net/phy/at803x.c
>> [...]
>>> @@ -191,6 +194,31 @@ static int at803x_config_init(struct phy_device
>> *phydev)
>>>    	return 0;
>>>    }
>>>
>>> +static int at803x_ack_interrupt(struct phy_device *phydev) {
>>> +	int err;
>>> +
>>> +	err = phy_read(phydev, AT803X_INSR);

>>      Could make this an initializer...

> Thank you very much. However I have no idea about "make this an initializer".

	int err = phy_read(phydev, AT803X_INSR);

WBR, Sergei
