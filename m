Return-Path: <michael@ellerman.id.au>
Date: Fri, 15 Mar 2013 00:42:12 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/11] Add platform_has_feature()
Message-ID: <20130314134212.GA6736@concordia>
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB457.9000409@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513AB457.9000409@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 08, 2013 at 10:02:31PM -0600, Nathan Fontenot wrote:
> The firmware_has_feature() function makes it easy to check for supported
> features of the hardware. There is not corresponding function to check for
> features supported by the client architecture.

Actually it doesn't tell you about features of the hardware, it tells
you about features of the firmware, or the platform ..

So I think you should really just be adding a new firmware feature flag,
and adding whatever glue code is required to set it based on what you
find in the device tree.

Also notice where you end up using it:

-       if (firmware_has_feature(FW_FEATURE_OPAL))
+       if (firmware_has_feature(FW_FEATURE_OPAL) ||
+           platform_has_feature(OV5_TYPE1_AFFINITY)) {
+               dbg("Using form 1 affinity\n");
		form1_affinity = 1;

Could be:

+       if (firmware_has_feature(FW_FEATURE_FORM1_AFFINITY) ||

cheers
