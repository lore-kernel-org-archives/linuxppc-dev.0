Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCB441A060F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jun 2014 00:41:35 +1000 (EST)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DC7E7140087
 for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2014 00:41:34 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@austin.ibm.com>;
 Fri, 27 Jun 2014 08:41:32 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B83E23E4004F
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 08:41:29 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5REeNLI5767434
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 16:40:23 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5REfRW0016739
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 08:41:29 -0600
Message-ID: <53AD8296.6040702@austin.ibm.com>
Date: Fri, 27 Jun 2014 09:41:26 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@linaro.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: OF_DYNAMIC node lifecycle
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>	<53A30117.3010100@austin.ibm.com>	<20140623144806.1348EC40A60@trevor.secretlab.ca>	<53A9DB4F.9060708@austin.ibm.com>	<20140625202446.77687C40AE6@trevor.secretlab.ca>	<53AC7C2D.3040604@austin.ibm.com>
 <20140627124101.367F7C40E5E@trevor.secretlab.ca>
In-Reply-To: <20140627124101.367F7C40E5E@trevor.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2014 07:41 AM, Grant Likely wrote:
> On Thu, 26 Jun 2014 15:01:49 -0500, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>> On 06/25/2014 03:24 PM, Grant Likely wrote:
>>> On Tue, 24 Jun 2014 15:10:55 -0500, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>>>>>> heh! I have often thought about adding reference counting to device tree
>>>>>> properties.
>>>>>
>>>>> You horrible, horrible man.
>>>>
>>>> Yes. I are evil :)
>>>>
>>>> After looking again the work needed to add reference counts to properties
>>>> would be huge. The few properties I am concerned with are specific to powerpc
>>>> so perhaps just adding an arch specific lock around updating those
>>>> properties would work.
>>>
>>> Which code/properties? I'd like to have a look myself.
>>
>> /ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
>>
>> The property is updated in 
>> arch/powerpc/platforms/pseries/hotplug-memory.c:pseries_update_drconf_memory()
> 
> Specifically, what do you need for the locking? Are you wanting to hold
> off additional changes while that function is executing? Pantelis is
> adding a mutex for device tree writers. Holding that mutex would prevent
> any changes from happening in the tree without affecting readers. Would
> that be sufficient?

That would work.

-Nathan
