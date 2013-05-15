Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEF1B2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 23:12:23 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Wed, 15 May 2013 10:12:18 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 90F7A1DC006A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 09:12:16 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4FDBG8v47054986
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 10:11:16 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4FDCBPr015775
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 10:12:15 -0300
Message-ID: <519389AA.8090707@linux.vnet.ibm.com>
Date: Wed, 15 May 2013 10:12:10 -0300
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCHv5 0/2] Speed Cap fixes for ppc64
References: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
 <1367622108.4389.129.camel@pasglop>
 <CADnq5_M9n0q4CucEhNqrJBjHsTh19ASsYr=nsUAJA_-mRr8qvQ@mail.gmail.com>
 <519380FF.4020703@linux.vnet.ibm.com>
 <CADnq5_POXuoDUQ3CX2GnYUzxE4SEoVyQq_k3tHdO2TnvDdXOUQ@mail.gmail.com>
In-Reply-To: <CADnq5_POXuoDUQ3CX2GnYUzxE4SEoVyQq_k3tHdO2TnvDdXOUQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Bjorn Helgaas <bhelgaas@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/15/2013 09:58 AM, Alex Deucher wrote:
> On Wed, May 15, 2013 at 8:35 AM, Kleber Sacilotto de Souza
> <klebers@linux.vnet.ibm.com> wrote:
>> On 05/06/2013 11:32 AM, Alex Deucher wrote:
>>>
>>> On Fri, May 3, 2013 at 7:01 PM, Benjamin Herrenschmidt
>>> <benh@kernel.crashing.org> wrote:
>>>>
>>>> On Fri, 2013-05-03 at 19:43 -0300, Kleber Sacilotto de Souza wrote:
>>>>
>>>>> This patch series does:
>>>>>     1. max_bus_speed is used to set the device to gen2 speeds
>>>>>     2. on power there's no longer a conflict between the pseries call and
>>>>> other
>>>>> architectures, because the overwrite is done via a ppc_md hook
>>>>>     3. radeon is using bus->max_bus_speed instead of
>>>>> drm_pcie_get_speed_cap_mask
>>>>> for gen2 capability detection
>>>>>
>>>>> The first patch consists of some architecture changes, such as adding a
>>>>> hook on
>>>>> powerpc for pci_root_bridge_prepare, so that pseries will initialize it
>>>>> to a
>>>>> function, while all other architectures get a NULL pointer. So that
>>>>> whenever
>>>>> pci_create_root_bus is called, we'll get max_bus_speed properly setup
>>>>> from
>>>>> OpenFirmware.
>>>>>
>>>>> The second patch consists of simple radeon changes not to call
>>>>> drm_get_pcie_speed_cap_mask anymore. I assume that on x86 machines,
>>>>> the max_bus_speed property will be properly set already.
>>>>
>>>>
>>>> So I'm ok with the approach now and I might even put the powerpc patch
>>>> in for 3.10 since arguably we are fixing a nasty bug (uninitialized
>>>> max_bus_speed).
>>>>
>>>> David, what's your feeling about the radeon change ? It would be nice if
>>>> that could go in soon for various distro targets :-) On the other hand
>>>> I'm not going to be pushy if you are not comfortable with it.
>>>
>>>
>>> FWIW, the radeon change looks fine to me.
>>>
>>> Alex
>>>
>>
>> Hi David,
>>
>> Are you planning to accept the radeon patch? If yes, can we still expect it
>> to make it for 3.10?
>>
>> As Ben mentioned, we have some distro targets to make and it would be nice
>> to have an outlook of the upstream acceptance to start the conversations
>> with those distros.
>
> Is the rest of this series already upstream?  I don't see a problem
> pulling it in if the rest of the patches are in Dave's tree.  Dave, do
> you want to grab this, or do you wan me to pull it in through my tree?
>
> Alex
>

The powerpc patch was applied by Ben and is already upstream.


Thanks,

-- 
Kleber Sacilotto de Souza
IBM Linux Technology Center
