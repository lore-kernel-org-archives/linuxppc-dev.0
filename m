Return-Path: <Ajit.Singh@vihaannetworks.com>
In-Reply-To: <466D0C56.3080804@dutchspace.nl>
To: Johan Borkhuis <j.borkhuis@dutchspace.nl>
Subject: Re: Question on nfsroot shared by multiple targets
MIME-Version: 1.0
Message-ID: <OFE578AB6C.02C24EBB-ON652572F7.0038F3B3-652572F7.0039B16A@shyamtelecom.com>
From: Ajit Singh <Ajit.Singh@vihaannetworks.com>
Date: Mon, 11 Jun 2007 15:56:28 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 0039B159652572F7_="
Cc: linuxppc-embedded-bounces+ajit.singh=vihaannetworks.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0039B159652572F7_=
Content-Type: text/plain; charset="US-ASCII"

Johan,

The way i had done it was creating a read only partition for the / (root) 
filesystem. The /var partition was the only one created seperately for the 
different mounted systems. The additional work done was to have a /var/etc 
with the links made from the /etc directory for the files that need change 
across the system. The entries softlink and if any file ctreation was done 
in the rcS scripts. It would take a bit of time, but it works.

regards
Ajit


Vihaan Networks Limited | 246, Phase - IV, Udyog Vihar, Gurgoan , PIN 
122015, Haryana, India, Phone: +91-124-4311712, Fax: +91-124-4104766 | 
www.vihaannetworks.com

DISCLAIMER This message and any attachment therewith is privileged, 
confidential and proprietary in nature and the property of the originator. 
It is intended solely and exclusively for use by the individual to whom it 
is addressed. It should not be circulated or used for any purpose other 
than for what is stated. If you have received this message erroneously, 
please notify the originator immediately. If you are not the intended 
recipient, you are notified that you are strictly prohibited from using, 
copying, altering, or disclosing the contents of this message and are 
called upon to delete the same from your system. Any contradictory action 
by you may invite penal consequences. Vihaan Networks Ltd. accepts no 
responsibility for loss or damage arising from the use of the information 
transmitted by this email including but not limited to damage from virus."



Johan Borkhuis <j.borkhuis@dutchspace.nl> 
Sent by: 
linuxppc-embedded-bounces+ajit.singh=vihaannetworks.com@ozlabs.org
06/11/07 02:18 PM

To
linuxppc-embedded@ozlabs.org
cc

Subject
Question on nfsroot shared by multiple targets






Hello,

I have the following setup: one server, with DHCP server and NFS-root 
for an embedded target. With one target this works OK, but now I want to 
add another target. The problem I see is that both targets are going to 
write into the same logfiles and lockfiles.
I did setup the DHCP server in such a way that the NFS-root of the 
target points to /nfsroot/<last octet of IP address>. But for this to 
work I need a copy of the complete tree for each target board. I would 
prefer to have only one tree for all targets, as this saves the effort 
of keeping all trees in sync.
I could create a smaller NFS-root per target, with only /etc, /var and 
some other directories and mount-points and mount all directories from a 
central nfsroot using the local fstab in /etc. This could work for /var, 
but I would still need to keep /etc in sync.

Is there another way to do this, or is this the correct way to setup a 
multi-target system?

Kind regards,
    Johan Borkhuis


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


--=_alternative 0039B159652572F7_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Johan,</font>
<br>
<br><font size=2 face="sans-serif">The way i had done it was creating a
read only partition for the / (root) filesystem. The /var partition was
the only one created seperately for the different mounted systems. The
additional work done was to have a /var/etc with the links made from the
/etc directory for the files that need change across the system. The entries
softlink and if any file ctreation was done in the rcS scripts. It would
take a bit of time, but it works.</font>
<br>
<br><font size=2 face="sans-serif">regards</font>
<br><font size=2 face="sans-serif">Ajit</font>
<br>
<br>
<br><font size=2 face="sans-serif">Vihaan Networks Limited | 246, Phase
- IV, Udyog Vihar, Gurgoan , PIN 122015, Haryana, India, Phone: +91-124-4311712,
Fax: +91-124-4104766 | www.vihaannetworks.com<br>
<br>
DISCLAIMER This message and any attachment therewith is privileged, confidential
and proprietary in nature and the property of the originator. It is intended
solely and exclusively for use by the individual to whom it is addressed.
It should not be circulated or used for any purpose other than for what
is stated. If you have received this message erroneously, please notify
the originator immediately. If you are not the intended recipient, you
are notified that you are strictly prohibited from using, copying, altering,
or disclosing the contents of this message and are called upon to delete
the same from your system. Any contradictory action by you may invite penal
consequences. Vihaan Networks Ltd. accepts no responsibility for loss or
damage arising from the use of the information transmitted by this email
including but not limited to damage from virus.&quot;</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Johan Borkhuis &lt;j.borkhuis@dutchspace.nl&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: linuxppc-embedded-bounces+ajit.singh=vihaannetworks.com@ozlabs.org</font>
<p><font size=1 face="sans-serif">06/11/07 02:18 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">linuxppc-embedded@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Question on nfsroot shared by multiple
targets</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2>Hello,<br>
<br>
I have the following setup: one server, with DHCP server and NFS-root <br>
for an embedded target. With one target this works OK, but now I want to
<br>
add another target. The problem I see is that both targets are going to
<br>
write into the same logfiles and lockfiles.<br>
I did setup the DHCP server in such a way that the NFS-root of the <br>
target points to /nfsroot/&lt;last octet of IP address&gt;. But for this
to <br>
work I need a copy of the complete tree for each target board. I would
<br>
prefer to have only one tree for all targets, as this saves the effort
<br>
of keeping all trees in sync.<br>
I could create a smaller NFS-root per target, with only /etc, /var and
<br>
some other directories and mount-points and mount all directories from
a <br>
central nfsroot using the local fstab in /etc. This could work for /var,
<br>
but I would still need to keep /etc in sync.<br>
<br>
Is there another way to do this, or is this the correct way to setup a
<br>
multi-target system?<br>
<br>
Kind regards,<br>
 &nbsp; &nbsp;Johan Borkhuis<br>
<br>
<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br>
</font></tt>
<br>
--=_alternative 0039B159652572F7_=--
