Message-ID: <81A66F72DCACD511B0600002A551BFCB4E9D62@kuumex05.barco.com>
From: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: possible bug in __wait_on_buffer 
Date: Mon, 10 Mar 2003 16:56:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I use cramfs to load the root of my system (MPC8245 based), All is good
excepted that the kernel crash on the line
run_task_queue(&tq_disk);
I checked if this queue(tq_disk) was used elsewhere( ie something put a task
in queue) but found only a raid5 driver using it.
So I disabled it. After that I received a decrementer interrupt on place.
A workaround consisting of a loop like this :
long j = jiffies+ 2* HZ;
while (jiffies < j ) schedule();
doesn't work.
Does someone encountered the same problem or is there a bug in another part
of the code ?

Regards,
----------------------------------------------------------------------------
------
Benoit Callebaut
Software Development Engineer
Barco | Control Rooms
Noordlaan 5, 8520 Kuurne, Belgium

Tel 	+32(0)56 36 84 28
Fax 	+32(0)56 36 86 05

mailto:benoit.callebaut@barco.com
http://www.barcocontrolrooms.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
