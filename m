Message-Id: <200304220519.AA02627@kishinami.cs.fujitsu.co.jp>
From: KISHINAMI Masaya <kishinami@cs.fujitsu.co.jp>
Date: Tue, 22 Apr 2003 14:19:51 +0900
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH][BUGFIX][2.4.21] Fix PPC4xx Ethernet problem
In-Reply-To: <5.1.0.14.2.20030421091806.0356ccf0@mail.ebshome.net>
References: <5.1.0.14.2.20030421091806.0356ccf0@mail.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- On Tue, 22 Apr 2003 01:27:09 +0900 Eugene Surovegin<ebs@ebshome.net> -san wrote:

>At 06:35 AM 4/21/2003, KISHINAMI Masaya wrote:
>
>>Attached file is effective the failure not to generate the receive
>>completion interruption from EMAC to 405GP On-chip LAN device driver.
>>The failure condition is as follows.
>>
>>- custom board designed based on the 405GP
>>- kernel 2.4.18
>>- 2.4.21 pre3 ibm_ocp LAN device driver and ported it to
>>   work on kernel 2.4.18
>>- repeater hub(10Mbps, half duplex)
>>- line is much loaded
>>
>>The modification was applied from 2.4.21 pre3.
>>Please see the follows URL. It describes in detail.
>>http://lists.linuxppc.org/linuxppc-embedded/200304/msg00171.html
>>Please apply attached file.
>
>This change looks very strange.
>
 I think so. I don't understand why this change is effective on
 the point of EMAC operation. The reason of applying this patch
 is just from the good test result and I think the failure is
 related to EMAC receiving handling, because many interruption was
 not generated on the special case that is stated above.

>1) Did you try your tests on the reference 405GP board (Walnut) ?

    Yes, however it never occurred the failure on the driver which
    did not apply the modification under heavy traffic. However,
    test environment is different in some reason. This failure
    occurs in one place at present, this is considered the line
    is much loaded in comparison to other place.

>    Maybe it's not a driver problem but your custom board.

     I'm sorry the part of title [BUGFIX] is my mistake. I think
     the failure is completely due to hardware issue. It would be
     helpful to apply the patch because I think the custom board
     is good and to avoid same trouble when new version is adopted.
     Custom board was tested on the engineering and product criteria
     and careful reinvestigation was not found the trouble. For
     example, two waveforms, receive clock and receive data ware
     almost same in comparison to good result another product's
     waveform under same test environment. Please be careful,
     two above products are different except mounting the 405GP.
     Also, 100Mbps clock waveform is fine and operates normally,
     therefore 10Mbps clock line is considered no problem.
     >
>2) Did you contact IBM? If yes, what did they say?

    Yes, via agent but not receive the respond as yet and made
    them to urge.

>
>3) Did you try new PPC 4xx ethernet driver in linuxppc-2.4 tree
>(bk://ppc.bkbits.net/linuxppc-2.4)?
>
    No, because it is considered the hardware issue so more try will
    in vain.

   It may remain the point what should be clear.
   I will keep you informed as more information becomes available.

Regards, Kishinami

-----
KISHINAMI Masaya
Fujitsu Limited (Japan)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
