From: jhart@abacus.bates.edu
Message-Id: <199907271901.PAA22932@abacus.bates.edu>
Subject: Netatalk  bug?, too many routes/iface
Date: Tue, 27 Jul 1999 15:02:27 -0400
To: "Markus Boie" <MBoie@Adobe.COM>
cc: "a sun" <asun@saul10.u.washington.edu>, "Rob Spellman" <rspell@bates.edu>,
        <linuxppc-dev@lists.linuxppc.org>,
        "Netatalk List" <netatalk-admins@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Markus Boie, MBoie@Adobe.COM writes:

>Konstantin wrote:
>>I just tried to play your game. Both interfaces on the same segment only
>>eth1 configured in the atalkd.conf. Everything seems to work fine - no
>>error messages. All the services show up.
>>RH-6.0 (kernel 2.2.5) netatalk-1.4b2+assun2.1.3.
>>I have only one network configured not a range. 
>>You may want to try to run it on a separate segment without other
>>machines, have one mac to test it. The problem may really be that you
>>have a too wide network range. 

>Jim Hart writes:

>>Here is the actual log entry:
>>
>>Jul 26 14:25:45 m1814 kernel: NET4: AppleTalk 0.18 for Linux NET4.0
>>Jul 26 14:25:56 m1814 atalkd[447]: restart (1.4b2+asun2.0a18.2)
>>Jul 26 14:25:57 m1814 atalkd[447]: zip_getnetinfo for eth0
>>Jul 26 14:25:57 m1814 atalkd[447]: rtmp_packet interface mismatch
>>Jul 26 14:25:57 m1814 atalkd[447]: zip gnireply from 1000.162 (eth0 12)
>>Jul 26 14:25:58 m1814 kernel: Too many routes/iface.
>>Jul 26 14:25:58 m1814 atalkd[447]: setifaddr: eth0: Invalid argument
>>Jul 26 14:25:59 m1814 papd[458]: restart (1.4b2+asun2.0a18.2)
>>Jul 26 14:25:59 m1814 afpd[467]: main: atp_open: Cannot assign requested 
>>address
>>Jul 26 14:25:59 m1814 afpd[467]: ASIP started on 134.181.128.227:548(1) 
>>(1.4b2+a
>>sun2.0a18.2)
>>
>>
>>Again, this is running LinuxPPC v4.1.
>>
>>The atalkd.conf contains just the one line "eth0", per Adrian's advice.  
>>There is only one Ethernet interface in the machine.  This is happening 
>>on all machines on which I've installed LinuxPPC v4.1, including an iMac, 
>>a PowerMac 7250 and a PowerMac 7350.

>Thanks Konstantin - that was indeed the problem. On our AppleTalk router 
>(Helios on a Sun) we had defined a network range of 1-60000. Setting this 
>to 1-200 was all I needed to do to make atalkd on the Linux box start.

I presume, then, that this is a bug in the Appletalk code in LinuxPPC, 
even though it's numbered 0.18, as compared to 0.17 in the Redhat 5.2 
we're running on our Intel machines.  The Intel machines have no problem 
with our network numbering ranges, which, according to our network 
administrator, can legally go from 1 to 65535.



--
Jim Hart
"He who gives up liberty for security ends up with neither." - Benjamin 
Franklin


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
