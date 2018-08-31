Return-Path: <userm57@yahoo.com>
Received: from sonic316-14.consmr.mail.bf2.yahoo.com
 (sonic316-14.consmr.mail.bf2.yahoo.com [74.6.130.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421k9H34vMzF389
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 12:39:59 +1000 (AEST)
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To: Rob Herring <robh+dt@kernel.org>
Cc: fthain@telegraphics.com.au, Frank Rowand <frank.rowand@sony.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <CAL_JsqLJ9QMHCMqGKpCouP1rTEO+cMGA1es94qAH+ukLsR31jg@mail.gmail.com>
From: Mac User <userm57@yahoo.com>
Message-ID: <569e4bc3-2149-4b2d-562f-e400dd05a8a8@yahoo.com>
Date: Thu, 30 Aug 2018 20:39:44 -0600
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLJ9QMHCMqGKpCouP1rTEO+cMGA1es94qAH+ukLsR31jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/29/18 7:05 PM, Rob Herring wrote:

> On Wed, Aug 29, 2018 at 7:44 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>> Hi Frank,
>>
>> Linux v4.17 and later will no longer boot on a G3 PowerMac. The boot hangs
>> very early, before any video driver loads.
>>
>> Stan and I were able to bisect the regression between v4.16 and v4.17 and
>> arrived at commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of
>> of_find_node_by_phandle()").
>>
>> I don't see any obvious bug in 0b3ce78e90fc or b9952b5218ad. But if you
>> revert these from v4.18 (which is also affected) that certainly resolves
>> the issue.
> Perhaps a bad assumption on phandle values causing a problem. Can you
> provide a dump of all the phandle or linux,phandle values from
> /proc/device-tree.
>
> Rob

Rob,

As suggested by Finn, I installed device-tree-compiler and
powerpc-ibm-utils.
 
Running "dtc -I fs -H both /sys/firmware/devicetree/base"
resulted in the following errors:

DTC: fs->dts on file "/sys/firmware/devicetree/base"
ERROR (name_properties): "name" property in
/pci/multifunc-device/pci1799,1#1 is incorrect ("pci1799,1" instead of
base node name)
ERROR (name_properties): "name" property in /pci/mac-io/ide#1 is
incorrect ("ide" instead of base node name)
ERROR (name_properties): "name" property in
/pci/mac-io/ide#1/atapi-disk#1 is incorrect ("atapi-disk" instead of
base node name)
ERROR (name_properties): "name" property in /cpus/PowerPC,750/l2-cache#1
is incorrect ("l2-cache" instead of base node name)
ERROR: Input tree has errors, aborting (use -f to force output)

If I force output with "-f", the resulting file has no occurrences 
of "phandle".

Running "lsprop /proc/device-tree | grep -i phandle" results in no 
output.

Please let me know if there's some other way to get information that 
would be helpful.

thanks

-Stan
