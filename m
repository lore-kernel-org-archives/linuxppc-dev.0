Date: Fri, 13 Aug 1999 09:56:56 -0400
From: "Christopher A. Shepherd" <cshepher@hardrock.com>
Message-Id: <199908131356.JAA08439@ns.hardrock.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: OF netbooting
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



All,

     I've been reading a bit on the list about iMac openfirmware netbooting,
reading the Apple technotes, etc. After looking over the NetBSD source tree,
it looks like the special ".note" section in the kernel file consists of
this:

-- snip (ofwmagic.S) --

        .section ".note"

        # note header

        # length of name
        .long   8

        # note descriptor size
        .long   20

        # note type (IEEE 1275)
        .long   0x1275

        # name of owner
        .asciz  "PowerPC"
        .balign 4


        # note descriptor

        # real mode (-1) or virtual mode (0)
        .long   0

        # real-base
        .long   -1
        # real-size
        .long   -1

        # virt-base
        .long   -1
        # virt-size
        .long   -1

-- snip --

     I built a special kernel by just assembling this and linking it into
the kernel. Won't be able to test it until I get back home though. Could it
really be this simple?

-Chris

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
