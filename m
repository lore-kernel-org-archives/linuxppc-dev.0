Return-Path: <chris.friesen@genband.com>
Received: from exprod7og120.obsmtp.com (exprod7og120.obsmtp.com [64.18.2.18])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 193EB2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 04:39:45 +1000 (EST)
Message-ID: <51670344.2090101@genband.com>
Date: Thu, 11 Apr 2013 12:39:00 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: recommended method of netbooting kernel/dtb in u-boot?
References: <5166DA49.5000907@genband.com>
 <3B81A930-A4AB-4AA7-BC36-FCCE55D33C66@kernel.crashing.org>
In-Reply-To: <3B81A930-A4AB-4AA7-BC36-FCCE55D33C66@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/2013 12:12 PM, Kumar Gala wrote:
>
> On Apr 11, 2013, at 10:44 AM, Chris Friesen wrote:
>
>>
>> Hi all,
>>
>> We've got a powerpc system that uses u-boot.  In our environment on
>> bootup u-boot does a DHCP to get networking info, then uses TFTP to
>> get the kernel, which then does DHCP again and NFS-mounts the
>> initial root filesystem.
>>
>> What's the standard practice for this sort of thing when using
>> device tree blobs?  Do most people use multi-file images or do they
>> TFTP scripts to load and execute separate kernel/dtb files?
>
> We've normally just done multiple tftp fetches and one grabs dtb and
> one grabs kernel.

Do you hardcode the path to the file in the firmware?  Or do you upload 
a script that knows the path to the file?

In our case the path to the boot file(s) depends on which slot the card 
being booted has been inserted in.  The DHCP server knows what the path 
is, so it can set dhcpd.conf appropriately, but we need to get that 
information to the firmware on the card being booted.

Chris
