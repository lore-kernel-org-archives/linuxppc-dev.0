Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from mail-qg0-x243.google.com (mail-qg0-x243.google.com
 [IPv6:2607:f8b0:400d:c04::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A9071A0221
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 04:48:31 +1100 (AEDT)
Received: by mail-qg0-x243.google.com with SMTP id 94so3002174qgt.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 09:48:31 -0800 (PST)
Subject: Re: [PATCH 5/6] ibmvscsi: Remove unsupported host config MAD and
 sysfs interface
To: Johannes Thumshirn <jthumshirn@suse.de>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1454542114-1797-6-git-send-email-tyreld@linux.vnet.ibm.com>
 <20160204080317.GT27969@c203.arch.suse.de>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 JBottomley@odin.com, linux-kernel@vger.kernel.org, hare@suse.de,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <56B38EE7.6060102@gmail.com>
Date: Thu, 4 Feb 2016 09:48:23 -0800
MIME-Version: 1.0
In-Reply-To: <20160204080317.GT27969@c203.arch.suse.de>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/04/2016 12:03 AM, Johannes Thumshirn wrote:
> On Wed, Feb 03, 2016 at 05:28:33PM -0600, Tyrel Datwyler wrote:
>> A VIOSRP_HOST_CONFIG_TYPE management datagram (MAD) has existed in
>> the code for some time. From what information I've gathered from
>> Brian King this was likely implemented on the host side in a SLES 9
>> based VIOS, which is no longer supported anywhere. Further, it is
>> not defined in PAPR or supported by any AIX based VIOS.
>>
>> Treating as bit rot and removing the sysfs interface and associated
>> host config code accordingly.
> 
> Doesn't removing a sysfs interface potentially break userspace code?
> 

In the general case yes, but I feel in this case no. First, Reading from
this config attribute of a vscsi host adapter always returns nothing.
Second, any userspace code using this attribute better be checking for
the existence of config. Just a quick look for
/sys/class/scsi_host/host*/config under other host adapters on my system
I find that attribute doesn't exist for any of them.

If there is truly enough concern that somebody may actually be accessing
this useless attribute from userspace then we can still strip out the
unsupported code, but leave the attribute and return nothing directly
from the show function.

-Tyrel
