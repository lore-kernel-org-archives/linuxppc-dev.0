Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66BBB1A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 17:32:09 +1000 (AEST)
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D13CA140134
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2015 17:32:03 +1000 (AEST)
Received: by pdea3 with SMTP id a3so70418389pde.3
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2015 00:32:01 -0700 (PDT)
Message-ID: <553B42EB.6080803@ozlabs.ru>
Date: Sat, 25 Apr 2015 17:31:55 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] pci: Use Qemu created PCI device nodes
References: <1429700240-32373-2-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150424213058.2889af29@thh440s>
In-Reply-To: <20150424213058.2889af29@thh440s>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/25/2015 05:30 AM, Thomas Huth wrote:
>
>   Hi Nikunj,
>
> On Wed, 22 Apr 2015 16:27:20 +0530
> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
>
>> PCI Enumeration has been part of SLOF. Now with hotplug code addition
>> in Qemu, it makes more sense to have this code a one place, i.e. Qemu.
>
> s/Qemu/QEMU/ and s/code a one place/code in one place/ ?
>
>> Adding routines to walk through the device nodes created by Qemu. SLOF
>> will configure the device/bridges and program the BARs for
>> communicating with the devices.
>
> I wonder whether it would make more sense to also set up the BARs etc.
> in QEMU instead of SLOF?

We need BAR setup in 2 cases: when SLOF needs to boot from a PCI device 
(and SLOF can do BAR setup) and when we do PCI hotplug - and BARs are set 
by the guest, otherwise we hit races here (Michael Roth can tell more). So 
as for today there is no reason for doing this in QEMU.




-- 
Alexey
