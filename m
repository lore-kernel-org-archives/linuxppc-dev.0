Return-Path: <sudeep.holla@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id D76A82C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 06:07:38 +1100 (EST)
Message-ID: <52CEF37B.9010401@arm.com>
Date: Thu, 09 Jan 2014 19:07:39 +0000
From: Sudeep Holla <Sudeep.Holla@arm.com>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC 1/3] drivers: base: support cpu cache information
 interface to userspace via sysfs
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
 <20140108202613.GD8417@kroah.com>
In-Reply-To: <20140108202613.GD8417@kroah.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Rob Herring <robh@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sudeep.Holla@arm.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/14 20:26, Greg Kroah-Hartman wrote:
> On Wed, Jan 08, 2014 at 07:26:06PM +0000, Sudeep Holla wrote:
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> This patch adds initial support for providing processor cache informatio=
n
>> to userspace through sysfs interface. This is based on x86 implementatio=
n
>> and hence the interface is intended to be fully compatible.
>>
>> A per-cpu array of cache information maintained is used mainly for
>> sysfs-related book keeping.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/base/Makefile     |   2 +-
>>  drivers/base/cacheinfo.c  | 296 +++++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/linux/cacheinfo.h |  43 +++++++
>>  3 files changed, 340 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/base/cacheinfo.c
>>  create mode 100644 include/linux/cacheinfo.h
>=20
> You are creating sysfs files, yet you didn't add Documentation/ABI/
> information, which is required.  Please fix that.
>=20
Ah, I overlooked it. But I am not creating any new sysfs files in this seri=
es.
I am just trying to unify duplicated code in various architectures.

Since these sysfs files are already created in:
1. arch/ia64/kernel/topology.c
2. arch/powerpc/kernel/cacheinfo.c
3. arch/s390/kernel/cache.c
4. arch/x86/kernel/cpu/intel_cacheinfo.c and
also already used by user-space tools like `lscpu` I assumed it's already
documented.

I will add it in next version.

Regards,
Sudeep
