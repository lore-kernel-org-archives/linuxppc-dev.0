From: "James Bates" <jbates@paradise.co.uk>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Executable delay
Date: Wed, 17 Dec 2003 17:11:07 -0000
Message-ID: <OJEPIMKHOKJAJIDJLJBNIEJPCAAA.jbates@paradise.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20031217093448.A18081@lists.linuxppc.org>
Reply-To: jbates@paradise.co.uk
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I'm getting some funny behaviour on my MPC8260ADS based system.

I am mounting my DiskOnChip 2000 on /mnt/doc. It all seems fine until I try
executing something from it. Trying to execute anything from the doc takes
ages, execution will not occur until a good 2 minutes after you have typed
the command. I have tried this with the most basic of programs and it still
does the same. Everthing runs fine when executed from the nfs mounted root
filesystem.

I know that this is not a hardware problem because I can boot into Bluecat
linux and access the filesystem without problems.

I have tried setting Use short timeouts but it makes no difference.

I have the latest eldk and 2.4.23 kernel from linuxppc_2_4_devel.


Looking into this problem a little deeper we put a logic analyser on the
DiskOnChip and discovered.

1) All large reads ( > ~10K get stuck)

2) Looking at the "top" output. Any process that accesses the DOC quickly
gets put into the D state (Task Uninterruptable).

3) Kicking off a new process brings the accessing process to life for a
short while it then goes back into the task uninterruptable state.

It smells like an mtd driver problem but I havn't the foggiest where to
start looking for the solution. Any ideas greatly received.

Kind Regards,

James Bates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
