Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp05.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B37922C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 22:35:28 +1000 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Wed, 15 May 2013 09:35:18 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 6136C352006C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 08:35:17 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4FCWCbi2023576
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 09:32:12 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r4FCZCr1008959
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 09:35:13 -0300
Message-ID: <519380FF.4020703@linux.vnet.ibm.com>
Date: Wed, 15 May 2013 09:35:11 -0300
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Airlie <airlied@linux.ie>
Subject: Re: [PATCHv5 0/2] Speed Cap fixes for ppc64
References: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
 <1367622108.4389.129.camel@pasglop>
 <CADnq5_M9n0q4CucEhNqrJBjHsTh19ASsYr=nsUAJA_-mRr8qvQ@mail.gmail.com>
In-Reply-To: <CADnq5_M9n0q4CucEhNqrJBjHsTh19ASsYr=nsUAJA_-mRr8qvQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Brian King <brking@linux.vnet.ibm.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Alex Deucher <alexdeucher@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2013 11:32 AM, Alex Deucher wrote:
> On Fri, May 3, 2013 at 7:01 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Fri, 2013-05-03 at 19:43 -0300, Kleber Sacilotto de Souza wrote:
>>
>>> This patch series does:
>>>    1. max_bus_speed is used to set the device to gen2 speeds
>>>    2. on power there's no longer a conflict between the pseries call and other
>>> architectures, because the overwrite is done via a ppc_md hook
>>>    3. radeon is using bus->max_bus_speed instead of drm_pcie_get_speed_cap_mask
>>> for gen2 capability detection
>>>
>>> The first patch consists of some architecture changes, such as adding a hook on
>>> powerpc for pci_root_bridge_prepare, so that pseries will initialize it to a
>>> function, while all other architectures get a NULL pointer. So that whenever
>>> pci_create_root_bus is called, we'll get max_bus_speed properly setup from
>>> OpenFirmware.
>>>
>>> The second patch consists of simple radeon changes not to call
>>> drm_get_pcie_speed_cap_mask anymore. I assume that on x86 machines,
>>> the max_bus_speed property will be properly set already.
>>
>> So I'm ok with the approach now and I might even put the powerpc patch
>> in for 3.10 since arguably we are fixing a nasty bug (uninitialized
>> max_bus_speed).
>>
>> David, what's your feeling about the radeon change ? It would be nice if
>> that could go in soon for various distro targets :-) On the other hand
>> I'm not going to be pushy if you are not comfortable with it.
>
> FWIW, the radeon change looks fine to me.
>
> Alex
>

Hi David,

Are you planning to accept the radeon patch? If yes, can we still expect 
it to make it for 3.10?

As Ben mentioned, we have some distro targets to make and it would be 
nice to have an outlook of the upstream acceptance to start the 
conversations with those distros.


Thanks!
-- 
Kleber Sacilotto de Souza
IBM Linux Technology Center
