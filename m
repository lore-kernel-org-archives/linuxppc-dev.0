Date: Wed, 5 Jul 2000 12:27:57 -0400 (EDT)
From: "TWG - pat, mark & steve" <twg@world.std.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with HardHat/NFS root filesystems
Message-ID: <Pine.SGI.3.95.1000705121641.27740C-100000@world.std.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks, Wolfgang, for your response.  It helped somewhat.  Here's what I
discovered:

1. I am also unable to run ash.static
2. I forgot to mention another error message (actually, I thought it was
trivial but it's not), I also get a "Warning: unable to open an initial
console" error message.

3. I also had to make a change when installing HHL, and I think this is
the key to my problem.  Basically, the RedHat install I chose left me with
a relatively small root partition, giving most of the disk space to
partitions mounted as /usr and /home.  Since the HHL stuff wouldn't fit in
/opt, I made a directory, /usr/opt, and linked it to /opt. (soft)

In /etc/exports, I export the volume as /opt/hardhat.....

However, when I do an "exportfs -av" the exported volume shows up as
/usr/opt/hardhat.....

I specified /opt/hardhat... in /etc/dhcpd.conf

I think, therefore, that NFS is not allowing access to the proper
directories, and that's why it can't find an init (or a /dev/console!)

Am I on the right track?
Thanks,
Mark Phillips


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
