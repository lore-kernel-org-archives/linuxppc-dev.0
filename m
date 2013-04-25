Return-Path: <benh@kernel.crashing.org>
Message-ID: <1366911329.2869.31.camel@pasglop>
Subject: Re: [PATCH 1/5] ibmebus: convert of_platform_driver to platform_driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robherring2@gmail.com>
Date: Fri, 26 Apr 2013 03:35:30 +1000
In-Reply-To: <CAL_JsqKDF=hPEM0Jz-zZSXBCXBZ=gBjLWL6QDvq+nFWkqY3DMw@mail.gmail.com>
References: <1366596798-9457-1-git-send-email-robherring2@gmail.com>
 <1366596798-9457-2-git-send-email-robherring2@gmail.com>
 <CAL_JsqKDF=hPEM0Jz-zZSXBCXBZ=gBjLWL6QDvq+nFWkqY3DMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Thu, 2013-04-25 at 10:23 -0500, Rob Herring wrote:
> Ben, Can I have your Ack for this? The change is straightforward and
> neither of the 2 drivers used the id parameter that is removed.

Didn't you get my mail about a compile failure caused by this patch ?

Or did you send an update that I missed ?

(Copy of the original email below)

Cheers,
Ben.

----

On Sun, 2013-04-21 at 21:13 -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> ibmebus is the last remaining user of of_platform_driver and the
> conversion to a regular platform driver is trivial.

A quick build test leads to:

/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c: In function 'ibmebus_bus_device_probe':
/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:344:2: error: implicit declaration of function 'to_platform_driver' [-Werror=implicit-function-declaration]
/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:344:6: error: assignment makes pointer from integer without a cast [-Werror]
/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c: In function 'ibmebus_bus_device_remove':
/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:363:32: error: initialization makes pointer from integer without a cast [-Werror]
/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c: In function 'ibmebus_bus_device_shutdown':
/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:373:32: error: initialization makes pointer from integer without a cast [-Werror]
/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c: In function 'ibmebus_bus_legacy_suspend':
/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:420:32: error: initialization makes pointer from integer without a cast [-Werror]
/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c: In function 'ibmebus_bus_legacy_resume':
/home/benh/linux-powerpc-test/arch/powerpc/kernel/ibmebus.c:431:32: error: initialization makes pointer from integer without a cast [-Werror]
cc1: all warnings being treated as errors
make[2]: *** [arch/powerpc/kernel/ibmebus.o] Error 1
make[2]: *** Waiting for unfinished jobs....

Haven't had a chance to look too closely today -EJETLAG :-)
