Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Fri, 16 Apr 2004 10:29:03 -0500
From: David Wolfe <david.wolfe@motorola.com>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Motorola Semiconductor Soliciting Input on the MPC5200 BestComm API Interface
Message-ID: <20040416152903.GA4649@orthanc.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Motorola Semiconductor has developed and supports the MPC5200
microprocessor. As you may be aware, the MPC5200 has a programmable DMA
module in it called the BestComm. The BestComm module is very powerful
in its ability to manage peripheral interfaces and reduce the processing
and interrupt load on the 603e core within the MPC5200.

Programming the BestComm engine requires a debugging environment that is
difficult to provide to environments outside of Motorola. Furthermore,
most users want to use the BestComm in the same manner: simply moving
data from the peripheral devices into memory. To maximize efficiency of
the data movement function of BestComm we are providing optimized and
validated BestComm tasks to our customers along with an API for using
those tasks. This API provides an important means for us to keep the
programming interface constant in the unexpected event of yet another
issue to be found (and corrected) in the BestComm task code. This is the
BestComm API that many of the Linux drivers utilize today. (The latest
version of the BestComm API was released on April 2, 2004.)

We believe that the BestComm API provides a simple and efficient interface
for writing BestComm enabled drivers for the MPC5200. The successes that
other RTOS's have had in incorporating the BestComm API bear this out.

To ensure your support we would like to understand your current
difficulties with the BestComm API and capture any ideas that you might
have for improving it.

Please be aware the latest new release of the API on April 2, 2004.
Wolfgang Denk has been kind enough to provide us with guidance on
Linux and has now offered to help us publish the BestComm API on his
cvs repository. Thank you Herr Denk. You can download the latest API at
www.denx.de:/cvsroot. The module name is, "linuxppc_2_4_devel."

We are currently considering the following enhancements to the BestComm
API:

License:
    We currently have a forked distribution of GPL and commercial
    licensing. We want a single distribution under an MIT-style license
    that can satisfy both our GPL and commercial partners. That is
    currently being investigated.

Namespace:
    The API has a global namespace pollution problem. This needs to be
    addressed. Further, the API could use a better, consistent global
    identifier prefix other than "Task" as it is now. This works fine
    for hardware validation but gets a little obscure beyond that.

Initialization:
    We would like to figure out a better initialization sequence for
    Linux drivers. Currently in the API all BestComm tasks (the microcode)
    are loaded at startup into SRAM. Other operating systems implement a
    "BestComm driver" that takes care of this. It is initialized before
    drivers using BestComm DMA. Sharing SRAM for use in deep sleep mode
    is needed.

Future enhancements:
    At some point in the future we would like to have a way to dynamically
    load and unload tasks and share SRAM. There are problems for the
    firmware doing this. We don't have a schedule for this work.

Best regards,
Alan Weiner & David Wolfe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
