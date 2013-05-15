Return-Path: <alexdeucher@gmail.com>
Received: from mail-ve0-x236.google.com (mail-ve0-x236.google.com
 [IPv6:2607:f8b0:400c:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC91C2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 22:58:13 +1000 (EST)
Received: by mail-ve0-f182.google.com with SMTP id da11so1927140veb.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 05:58:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <519380FF.4020703@linux.vnet.ibm.com>
References: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
 <1367622108.4389.129.camel@pasglop>
 <CADnq5_M9n0q4CucEhNqrJBjHsTh19ASsYr=nsUAJA_-mRr8qvQ@mail.gmail.com>
 <519380FF.4020703@linux.vnet.ibm.com>
Date: Wed, 15 May 2013 08:58:08 -0400
Message-ID: <CADnq5_POXuoDUQ3CX2GnYUzxE4SEoVyQq_k3tHdO2TnvDdXOUQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/2] Speed Cap fixes for ppc64
From: Alex Deucher <alexdeucher@gmail.com>
To: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Wed, May 15, 2013 at 8:35 AM, Kleber Sacilotto de Souza
<klebers@linux.vnet.ibm.com> wrote:
> On 05/06/2013 11:32 AM, Alex Deucher wrote:
>>
>> On Fri, May 3, 2013 at 7:01 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>>>
>>> On Fri, 2013-05-03 at 19:43 -0300, Kleber Sacilotto de Souza wrote:
>>>
>>>> This patch series does:
>>>>    1. max_bus_speed is used to set the device to gen2 speeds
>>>>    2. on power there's no longer a conflict between the pseries call and
>>>> other
>>>> architectures, because the overwrite is done via a ppc_md hook
>>>>    3. radeon is using bus->max_bus_speed instead of
>>>> drm_pcie_get_speed_cap_mask
>>>> for gen2 capability detection
>>>>
>>>> The first patch consists of some architecture changes, such as adding a
>>>> hook on
>>>> powerpc for pci_root_bridge_prepare, so that pseries will initialize it
>>>> to a
>>>> function, while all other architectures get a NULL pointer. So that
>>>> whenever
>>>> pci_create_root_bus is called, we'll get max_bus_speed properly setup
>>>> from
>>>> OpenFirmware.
>>>>
>>>> The second patch consists of simple radeon changes not to call
>>>> drm_get_pcie_speed_cap_mask anymore. I assume that on x86 machines,
>>>> the max_bus_speed property will be properly set already.
>>>
>>>
>>> So I'm ok with the approach now and I might even put the powerpc patch
>>> in for 3.10 since arguably we are fixing a nasty bug (uninitialized
>>> max_bus_speed).
>>>
>>> David, what's your feeling about the radeon change ? It would be nice if
>>> that could go in soon for various distro targets :-) On the other hand
>>> I'm not going to be pushy if you are not comfortable with it.
>>
>>
>> FWIW, the radeon change looks fine to me.
>>
>> Alex
>>
>
> Hi David,
>
> Are you planning to accept the radeon patch? If yes, can we still expect it
> to make it for 3.10?
>
> As Ben mentioned, we have some distro targets to make and it would be nice
> to have an outlook of the upstream acceptance to start the conversations
> with those distros.

Is the rest of this series already upstream?  I don't see a problem
pulling it in if the rest of the patches are in Dave's tree.  Dave, do
you want to grab this, or do you wan me to pull it in through my tree?

Alex
