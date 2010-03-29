Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-pz0-f181.google.com (mail-pz0-f181.google.com
	[209.85.222.181]) by ozlabs.org (Postfix) with ESMTP id 4E38CB7CBD
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 11:05:06 +1100 (EST)
Received: by pzk11 with SMTP id 11so1392295pzk.17
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Mar 2010 17:05:04 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <4BAF1DC2.2080600@embedded-sol.com>
References: <4B8E6FA3.70503@embedded-sol.com>
	<4B9AC885.3010107@embedded-sol.com> <4B9DC820.2060100@jp.fujitsu.com>
	<4B9DCF01.4050709@embedded-sol.com> <4B9DF72F.3040105@jp.fujitsu.com>
	<4B9E18A7.2080605@embedded-sol.com> <4B9F19E2.2090709@jp.fujitsu.com>
	<4B9FFAD1.8030309@embedded-sol.com> <4BA02A49.9050101@jp.fujitsu.com>
	<4BAF1DC2.2080600@embedded-sol.com>
Date: Sun, 28 Mar 2010 17:05:03 -0700
Message-ID: <86802c441003281705v7d911553q4ee6f385c856644d@mail.gmail.com>
Subject: Re: Problem with PCI bus rescan on 460EX
From: Yinghai Lu <yinghai@kernel.org>
To: Felix Radensky <felix@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-pci@vger.kernel.org, Alex Chiang <achiang@hp.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 28, 2010 at 2:13 AM, Felix Radensky <felix@embedded-sol.com> wrote:
> Hello, Kenji-san
>
> I've tried Jesse's tree with Yinghai's patches, but they don't seem to help.
> Memory for bridge is not allocated after insertion of hotplug device and
> bus rescan. Attached dmesg output in case of success and failure.
>
that patches only take care of pcie hotplug path...

and it calls
pci_assign_unassigned_bridge_resources(bridge)
instead of
pci_bus_assign_resources(bus)

so it doesn't check pci_is_enabled()

maybe  We can update rescan path to check if it is safe to skip the
pci_is_enabled() too.
  - no driver for those devices under that bridge are loaded.

YH
