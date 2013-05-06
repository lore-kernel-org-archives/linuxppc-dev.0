Return-Path: <j.glisse@gmail.com>
Received: from mail-qc0-x235.google.com (mail-qc0-x235.google.com
 [IPv6:2607:f8b0:400d:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B7822C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 00:33:58 +1000 (EST)
Received: by mail-qc0-f181.google.com with SMTP id s25so1732473qcq.26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 07:33:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADnq5_M9n0q4CucEhNqrJBjHsTh19ASsYr=nsUAJA_-mRr8qvQ@mail.gmail.com>
References: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
 <1367622108.4389.129.camel@pasglop>
 <CADnq5_M9n0q4CucEhNqrJBjHsTh19ASsYr=nsUAJA_-mRr8qvQ@mail.gmail.com>
Date: Mon, 6 May 2013 10:33:55 -0400
Message-ID: <CAH3drwaagtnhQMxJimhJQ-93Jws7+QBJ5Pwk-VynSeNu7Nr6DQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/2] Speed Cap fixes for ppc64
From: Jerome Glisse <j.glisse@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dri-devel@lists.freedesktop.org, Brian King <brking@linux.vnet.ibm.com>,
 Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher <alexander.deucher@amd.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

n Mon, May 6, 2013 at 10:32 AM, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Fri, May 3, 2013 at 7:01 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Fri, 2013-05-03 at 19:43 -0300, Kleber Sacilotto de Souza wrote:
>>
>>> This patch series does:
>>>   1. max_bus_speed is used to set the device to gen2 speeds
>>>   2. on power there's no longer a conflict between the pseries call and other
>>> architectures, because the overwrite is done via a ppc_md hook
>>>   3. radeon is using bus->max_bus_speed instead of drm_pcie_get_speed_cap_mask
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

As said previously, looks fine to me too.

Cheers,
Jerome
