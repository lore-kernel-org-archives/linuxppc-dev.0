Return-Path: <mita@fixstars.com>
Message-ID: <39455.202.227.43.1.1182735882.squirrel@webmail.fixstars.com>
In-Reply-To: <20070622161039.2d863fd9@localhost>
References: <20070621130944.083f8fa5@localhost>
	<20070621131644.03a8ec31@localhost>
	<20070621140731.GA24496@ps3linux.grid.fixstars.com>
	<20070622161039.2d863fd9@localhost>
Date: Mon, 25 Jun 2007 10:44:42 +0900 (JST)
Subject: Re: [Cbe-oss-dev] [patch 1/5] cell: pmi remove support for mutiple
	devices.
From: "Akinobu Mita" <mita@fixstars.com>
To: "Christian Krafft" <krafft@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-2022-jp
Cc: Akinobu Mita <mita@fixstars.com>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>> > -kfree(dev->dev.driver_data);
>> > +kfree(data);
>>
>> Shouldn't it set data = NULL here?
>>
>> I guess we will get "pmi: driver has already been initialized" message
>> and -EBUSY on reloading pmi driver.
>>
>> >
>> >  return 0;
>> >  }
>
> That problem did actually not occur.
> Anyway, I added the line for completeness and consistency.

The data is located in module data. So unloading module clean up
the data, too. I missed it.

In order to test the problem I said, we need to re-probe pmi driver
without unloading pmi driver. (http://lwn.net/Articles/143397/)

I hope your updated version of patch fixes the problem.
