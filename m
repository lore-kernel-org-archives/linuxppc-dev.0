Date: Sun, 9 Jul 2000 18:49:04 -0700 (PDT)
From: Matt Brubeck <mbrubeck@hmc.edu>
To: Tom Vier <thomassr@erols.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: RFC: Changing default partition type for linux/ppc
In-Reply-To: <20000709203316.A12712@zero>
Message-ID: <Pine.GSO.4.21.0007091842050.11395-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 9 Jul 2000, Tom Vier wrote:

>> If we put the fs type (like Linux_ext2) in the partition type, it's
>> not updated by the various linux mkxxxx tools, and can be confusing.
>> I would rather keep a simple "Linux" type, along with "Linux_swap" to
>> help skipping swap partition in bootloaders (and installers)

> i'm not sure what you're saying. mkfs doesn't touch partition tables.

That's the problem. If we create a partition with the label "ext2" and
later use mkfs to change the filesystem on that partition, the label stays
and is misleading.

Because people don't always change their partition tables when they switch
filesystems or operating systems, any label is liable to become
inconsistant with the actual disk state. Therefore, these type labels
should be used only as hints to bootloaders and installers and such; there
should always be a way to ignore them.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
