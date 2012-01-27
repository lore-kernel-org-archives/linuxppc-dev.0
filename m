Return-Path: <joey@joescan.com>
Received: from exprod7og114.obsmtp.com (exprod7og114.obsmtp.com [64.18.2.215])
 by ozlabs.org (Postfix) with SMTP id 71C04B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2012 07:43:28 +1100 (EST)
Received: by vbbfq11 with SMTP id fq11so2089320vbb.37
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 12:43:26 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 27 Jan 2012 12:14:35 -0800
Message-ID: <CAL_WD7hYZoaB87vZzj4Fk9nsHYSoe+qWq87g72ERLAkMur5vYg@mail.gmail.com>
Subject: MPC5200B FEC TX packets getting stuck
From: Joey Nelson <joey@joescan.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=bcaec5015f2b42ac9d04b78825b0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec5015f2b42ac9d04b78825b0
Content-Type: text/plain; charset=ISO-8859-1

In my application, I have a PC connected through TCP to a MPC5200B based
system.  The PC sends a short request, the MPC5200B receives the request
and sends the data back.  It is doing this about 300 times per second.
 Normally exchange happens in just handful of milliseconds.  But randomly
every 2 to 15 minutes the MPC5200B sends all but the last packet of the
response, and about 200ms later the PC sends a delayed ACK, and the
MPC5200B TCP stack figures the packet was lost.  It then sends two nearly
identical packets (The IP header Identification and Checksum fields are
incremented).  I can also see that RetransSegs in /proc/net/snmp increments
by one for each of these delays.

My theory is that the packet is getting suck somewhere in the network stack
(most likely toward the bottom).  Then when another packet is sent, the
suck one gets pushed out.

I've done a test where I have another task on the MPC5200B sending UDP
packets to a different PC every 10ms.  This eliminated the long delays, and
seems to support my stuck packet theory.

I'm seeing the same issue with 2.6.23 and 3.1.6.

I'm getting ready to dive into the hairy world of Bestcomm and FEC, but I
figured I'd see if anyone else has any suggestions before I make my decent.
 Has anyone seen this behavior before?  Any likely candidates for where the
packet is getting stuck?  General advice for reference materials (I've
started on Linux Device Drivers 3rd Ed, BestComm AN2604, and the Datasheets)

Thanks in advance.

Joey Nelson
joey@joescan.com

--bcaec5015f2b42ac9d04b78825b0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><br></div><div>In my application, I have a PC connected through TCP to=
 a MPC5200B based system. =A0The PC sends a short request, the MPC5200B=A0r=
eceives=A0the request and sends the data back. =A0It is doing this about 30=
0 times per second. =A0Normally exchange happens in just handful of millise=
conds. =A0But randomly every 2 to 15 minutes the MPC5200B sends all but the=
 last packet of the response, and about 200ms later the PC sends a delayed =
ACK, and the MPC5200B TCP stack figures the packet was lost. =A0It then sen=
ds two nearly identical packets (The IP header Identification and Checksum =
fields are incremented). =A0I can also see that RetransSegs in /proc/net/sn=
mp increments by one for each of these delays.</div>
<div><br></div><div>My theory is that the packet is getting suck somewhere =
in the network stack (most likely toward the bottom). =A0Then when another =
packet is sent, the suck one gets pushed out.</div><div><br></div><div>I&#3=
9;ve done a test where I have another task on the MPC5200B sending UDP pack=
ets to a different PC every 10ms. =A0This eliminated the long delays, and s=
eems to support my stuck packet theory.</div>
<div><br></div><div>I&#39;m seeing the same issue with 2.6.23 and 3.1.6.</d=
iv><div><br></div><div>I&#39;m getting ready to dive into the hairy world o=
f Bestcomm and FEC, but I figured I&#39;d see if anyone else has any sugges=
tions before I make my decent. =A0Has anyone seen this=A0behavior=A0before?=
 =A0Any likely candidates for where the packet is getting stuck? =A0General=
 advice for reference materials (I&#39;ve started on Linux Device Drivers 3=
rd Ed, BestComm AN2604, and the Datasheets)</div>
<div><br></div><div>Thanks in advance.</div><br clear=3D"all">Joey Nelson<d=
iv><a href=3D"mailto:joey@joescan.com">joey@joescan.com</a><br><br>
</div>

--bcaec5015f2b42ac9d04b78825b0--
