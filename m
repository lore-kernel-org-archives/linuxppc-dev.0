Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F537DDF1C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 03:48:24 +1100 (EST)
Message-Id: <C486295F-74E1-4A24-A8FE-C7BD446A53F5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081217154111.GA21335@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/5] powerpc/qe: Implement QE Pin Multiplexing API
Date: Wed, 17 Dec 2008 10:46:17 -0600
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
	<20081203192738.GA13035@oksana.dev.rtsoft.ru>
	<20081217154111.GA21335@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 17, 2008, at 9:41 AM, Anton Vorontsov wrote:

> On Wed, Dec 03, 2008 at 10:27:38PM +0300, Anton Vorontsov wrote:
>> With this API we're able to set a QE pin to the GPIO mode or a  
>> dedicated
>> peripheral function.
>>
>> The API relies on the fact that QE gpio controllers are registered.  
>> If
>> they aren't, the API won't work (gracefully though).
>>
>> There is one caveat though: if anybody occupied the node->data  
>> before us,
>> or overwrote it, then bad things will happen. Luckily this is all  
>> in the
>> platform code that we fully control, so this should never happen.
>>
>> I could implement more checks (for example we could create a list of
>> successfully registered QE controllers, and compare the node->data  
>> in the
>> qe_pin_request()), but this is unneeded if nobody is going to do  
>> silly
>> things behind our back.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>
> Kumar, can you please merge this patch? It is the last patch that
> holds the FHCI USB driver.
>
> Thanks,

Will do.  Can I get you to add kdoc comments for the API functions:

+extern struct qe_pin *qe_pin_request(struct device_node *np, int  
index);
+extern void qe_pin_free(struct qe_pin *qe_pin);
+extern void qe_pin_set_gpio(struct qe_pin *qe_pin);
+extern void qe_pin_set_dedicated(struct qe_pin *pin);

- k
