Return-Path: <robherring2@gmail.com>
Message-ID: <517980B0.3000401@gmail.com>
Date: Thu, 25 Apr 2013 14:14:56 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] ibmebus: convert of_platform_driver to platform_driver
References: <1366596798-9457-1-git-send-email-robherring2@gmail.com>
 <1366596798-9457-2-git-send-email-robherring2@gmail.com>
 <CAL_JsqKDF=hPEM0Jz-zZSXBCXBZ=gBjLWL6QDvq+nFWkqY3DMw@mail.gmail.com>
 <1366911329.2869.31.camel@pasglop>
In-Reply-To: <1366911329.2869.31.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Roland Dreier <roland@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Raisch <raisch@de.ibm.com>, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Grant Likely <grant.likely@linaro.org>, Paul Mackerras <paulus@samba.org>,
 Sean Hefty <sean.hefty@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Hal Rosenstock <hal.rosenstock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/25/2013 12:35 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-04-25 at 10:23 -0500, Rob Herring wrote:
>> Ben, Can I have your Ack for this? The change is straightforward and
>> neither of the 2 drivers used the id parameter that is removed.
> 
> Didn't you get my mail about a compile failure caused by this patch ?

No, and I can't find any evidence of a mail in my inbox or in the list
archives.

> 
> A quick build test leads to:
> 
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c: In function 'ibmebus_bus_device_probe':
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:344:2: error: implicit declaration of function 'to_platform_driver' [-Werror=implicit-function-declaration]
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:344:6: error: assignment makes pointer from integer without a cast [-Werror]
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c: In function 'ibmebus_bus_device_remove':
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:363:32: error: initialization makes pointer from integer without a cast [-Werror]
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c: In function 'ibmebus_bus_device_shutdown':
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:373:32: error: initialization makes pointer from integer without a cast [-Werror]
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c: In function 'ibmebus_bus_legacy_suspend':
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:420:32: error: initialization makes pointer from integer without a cast [-Werror]
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c: In function 'ibmebus_bus_legacy_resume':
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:431:32: error: initialization makes pointer from integer without a cast [-Werror]
> cc1: all warnings being treated as errors
> make[2]: *** [arch/powerpc/kernel/ibmebus.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> 
> Haven't had a chance to look too closely today -EJETLAG :-)

You need patch 2 of this series to fix this:

driver core: move to_platform_driver to platform_device.h

which as Arnd pointed out needs to come first. I've fixed that in my
tree, but I don't think it warrants another post.

Rob
