Date: Sun, 6 Dec 1998 20:31:21 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: VALETTE Eric <valette@crf.canon.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Incomplete (potentially broken) Raven Chipset support for PREP machines.
In-Reply-To: <Pine.LNX.3.96.981204114648.5989A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.HPP.3.96.981206202328.17076R-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 4 Dec 1998, Cort Dougan wrote:

> 
> }OK. on the other hand it is not because single a board is broken that all board
> }must use a much more complex method. I agree that parsing of residual is
> }needed for ISA PNP devices but for PCI devices???
> 
> Not just a single board.  The current method works and I'm very hesitant
> to change it before 2.2  If you can find a cleaner method that'd be great,
> but it would have to be in 2.2.  What different method do you propose?

Actually the names raven and prep in the config method routines are
misleading, all Motorola bridges I know support this method (106, 106 and
Raven), and it should be used since it is more flexible than the direct
mapped method also supported by the 105 and 106 but not by the Raven.

Using the residual data for this is the Right Way (TM), although we should
do something for non residual data present. 

> 
> }I can just agree. On the other hand, I have clean code for Open PIC
> }interrupt handling that do not differ to much from what I have seen in
> }the CHRP code...
> 
> I use the openpic code for the mpic controller on the totalmp board as
> well.
> 
> You didn't answer how you'd solve the interrupt mapping problem.  I'd love
> to hear any solutions to the current mess.

I have code which correctly extracts the interrupt routing from the
residual data, I hope to make it public next week, it has been working
for two weeks on my MVME2600 and simply needs some cleanup:

[root@vcorr1 ppc]# cat /proc/interrupts
           CPU0       
  1:          8     82c59     keyboard
  2:          0     82c59     cascade
  4:        191     82c59     serial
 16:          0   OpenPIC     82c59 cascade
 18:      17047   OpenPIC     DC21140 (eth0)
 19:       7429   OpenPIC     ncr53c8xx
 21:       7542   OpenPIC     vme (universe)
BAD:          1               spurious or short

and for people interested in VME here are the other goodies I've been
writing in the last 2 weeks (back with more on it on Wednesday):

[root@vcorr1 ppc]# cat /proc/bus/vme/devices
  0     universe
  1     bc336
[root@vcorr1 ppc]# cat /proc/bus/vme/interrupts 
Level Vector:      Count        Device/Interrupt
    6    146:          0        bc336/event
    5    145:      55785        bc336/heartbeat
    3    144:        113        bc336/1pps
[root@vcorr1 ppc]# cat /proc/bus/vme/regions    
 A16 D32 USER   0000c000-0000cfff       bc336
[root@vcorr1 ppc]# ksyms                     
Address   Symbol                            Defined by
c40112c0  vme_unregister                    [universe]
c40110f0  vme_remove_region                 [universe]
c401127c  vme_register                      [universe]
c40111ec  vme_free_interrupt                [universe]
c4011048  vme_add_region                    [universe]
c4011158  vme_request_interrupt             [universe]


	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
