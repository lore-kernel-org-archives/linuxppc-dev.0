Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8BAA5DDF7A
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 05:36:49 +1000 (EST)
In-Reply-To: <200706082126.23435.arnd@arndb.de>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<1181271180.6026.10.camel@concordia.ozlabs.ibm.com>
	<cc1d6d368ded181bbbdad8e4f4cb37ae@kernel.crashing.org>
	<200706082126.23435.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <65a522813f1b95748a3acc0c05e0285c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Fri, 8 Jun 2007 21:36:39 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> + =A0 =A0 =A0 for_each_compatible_node(node, NULL, =
"ibm,axon-msic") {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =
(axon_msi_setup_one(of_node_get(node)) =3D=3D 0)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found++;
>>>>> + =A0 =A0 =A0 }
>>>>> + =A0 =A0 =A0 of_node_put(node);
>>
>> So where is the of_node_put() done for the of_node_get()
>> inside the loop?
>
> of_find_compatible_node does an of_node_put() on the device_node
> that you pass in as the 'from' argument. In the last step, 'node'
> is set to NULL and we put the previous element.

That wasn't my question though?


Segher
