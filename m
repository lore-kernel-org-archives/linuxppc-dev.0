Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 924761A028F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 10:44:33 +1000 (EST)
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
 [209.85.223.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E02B31400B5
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2014 10:44:31 +1000 (EST)
Received: by mail-ie0-f173.google.com with SMTP id tr6so1821792ieb.18
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2014 17:44:29 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <53C706D2.7080207@austin.ibm.com>
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
 <53A30117.3010100@austin.ibm.com>
 <20140623144806.1348EC40A60@trevor.secretlab.ca>
 <53A9DB4F.9060708@austin.ibm.com>
 <20140625202446.77687C40AE6@trevor.secretlab.ca>
 <53AC7C2D.3040604@austin.ibm.com>
 <20140627124101.367F7C40E5E@trevor.secretlab.ca>
 <53AD8296.6040702@austin.ibm.com>
 <CACxGe6u5bVwYZjux9F2xzZSxZOSe37DGemCgcYtmiTP-xenQfg@mail.gmail.com>
 <53C6C4BE.6010301@gmail.com>
 <CACxGe6v8BgEcTRB-ftPVkR6Tqs3GPw_0fVuwFgff_VqawoocGA@mail.gmail.com>
 <CACxGe6scb291V9rjz2P48FxCEtXEEtOkgiQms=nZ_wdOf_cqHA@mail.gmail.com>
 <53C706D2.7080207@austin.ibm.com>
From: Grant Likely <grant.likely@linaro.org>
Date: Wed, 16 Jul 2014 18:44:09 -0600
Message-ID: <CACxGe6vfOa3dMoE7BYt5YAJ39yA9b0A8SJMRZiXpCsvBfQ5dOQ@mail.gmail.com>
Subject: Re: OF_DYNAMIC node lifecycle
To: Nathan Fontenot <nfont@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2014 at 5:12 PM, Nathan Fontenot <nfont@austin.ibm.com> wrote:
> On 07/16/2014 05:26 PM, Grant Likely wrote:
>> On Wed, Jul 16, 2014 at 2:57 PM, Grant Likely <grant.likely@linaro.org> wrote:
>>> On Wed, Jul 16, 2014 at 12:30 PM, Tyrel Datwyler
>>> <turtle.in.the.kernel@gmail.com> wrote:
>>>> On 07/15/2014 10:33 PM, Grant Likely wrote:
>>>>> I've got another question about powerpc reconfiguration. I was looking
>>>>> at the dlpar_configure_connector() function in dlpar.c. I see that the
>>>>> function has the ability to process multiple nodes with additional
>>>>> sibling and child nodes. It appears to link them into a detached tree
>>>>> structure, and the function returns a pointer to the first node.
>>>>>
>>>>> All of the callers of that function then call dlpar_attach_node(),
>>>>> which calls of_attach_node(). However, of_attach_node() only handles a
>>>>> single node. It doesn't handle siblings or children. Is this a bug?
>>>>> Does the configure connector ever actually receive more than one node
>>>>> at once?
>>>>
>>>> Yes, it is sometimes the case we will get a tree structure back of more
>>>> than one node. Under the proc interface implementation this just worked.
>>>> With the move to sysfs it appears we have a regression here. What makes
>>>> more sense here, for us to walk the tree calling of_attach_node, or to
>>>> move such tree walking logic into of_attach_node? From what I can tell
>>>> we are the only consumers of of_attach_node.
>>>
>>> That is very shortly going to change. The overlay code also uses
>>> of_attach_node(). I can make of_attach_node() recurse over
>>> descendants, but I'm also considering moving the powerpc code over to
>>> the of_changeset series that Panto and I are working on.
>>>
>>> Either way, the handling of multiple nodes should be common code. I
>>> think the easiest is to put the recursion into of_attach_node(), at
>>> least for fixing the bug. It can be reworked later.
>>
>> On pseries, do notifiers ever fail? ie. Does the reconfig code ever
>> object to a DT change and prevent it from being applied?
>>
> I cannot think of a time that  I ever saw a notifier fail.

Good to know. I was hoping it wasn't part of the design. I can't think
of any situation where the kernel would want to inhibit a change to
the device tree.

Can you take a look at the following tree and give it a spin on
PowerPC. I've reordered the notifiers and hopefully got the powerpc
fixups right, but I don't have a way to test it...

The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e59d1:

  Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux devicetree/next-overlay

for you to fetch changes up to 44ac93bb5583c5f1f85912309fe04045b61a6dd0:

  of: Transactional DT support. (2014-07-16 16:44:07 -0600)

----------------------------------------------------------------
Grant Likely (6):
      of/platform: Fix of_platform_device_destroy iteration of devices
      of: Move CONFIG_OF_DYNAMIC code into a separate file
      of: Make sure attached nodes don't carry along extra children
      of: Move dynamic node fixups out of powerpc and into common code
      of: Make OF_DYNAMIC user selectable
      of: Reorder device tree changes and notifiers

Pantelis Antoniou (5):
      of: rename of_aliases_mutex to just of_mutex
      OF: Utility helper functions for dynamic nodes
      of: Create unlocked versions of node and property add/remove functions
      of: Make devicetree sysfs update functions consistent.
      of: Transactional DT support.

 Documentation/devicetree/changesets.txt         |  41 ++
 arch/powerpc/kernel/prom.c                      |  70 ---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   2 +-
 drivers/crypto/nx/nx-842.c                      |  30 +-
 drivers/of/Kconfig                              |   2 +-
 drivers/of/Makefile                             |   1 +
 drivers/of/base.c                               | 423 ++++-----------
 drivers/of/device.c                             |   4 +-
 drivers/of/dynamic.c                            | 671 ++++++++++++++++++++++++
 drivers/of/of_private.h                         |  59 ++-
 drivers/of/platform.c                           |  32 +-
 drivers/of/selftest.c                           |  79 +++
 drivers/of/testcase-data/testcases.dtsi         |  10 +
 include/linux/of.h                              |  80 ++-
 include/linux/of_platform.h                     |   7 +-
 15 files changed, 1067 insertions(+), 444 deletions(-)
 create mode 100644 Documentation/devicetree/changesets.txt
 create mode 100644 drivers/of/dynamic.c
