Return-Path: <s.deepak@gdatech.co.in>
Received: from mail.gdatech.co.in (mail.gdatech.co.in [220.225.128.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.gdatech.co.in",
	Issuer "mail.gdatech.co.in" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 81DB667B28
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 May 2005 16:56:30 +1000 (EST)
Content-Type: multipart/mixed; boundary="=-bd-boundary-Ev8yDkhKB5bIMy7K"
Mime-Version: 1.0
Message-ID: <02cb01c54ee3$87e93ec0$4000a8c0@DeepakS>
From: "s.deepak" <s.deepak@gdatech.co.in>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 2 May 2005 12:22:39 +0530
Subject: Memory Usage Growth in File access
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format,
containing the original message body
and a footer added by BitDefender

--=-bd-boundary-Ev8yDkhKB5bIMy7K
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_02C8_01C54F11.A1790B30"

This is a multi-part message in MIME format.

------=_NextPart_000_02C8_01C54F11.A1790B30
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,

I am  facing an issue in file operation, when we read/write continuously =
to  a large file in our  ppc 405 based device , memory usage shown in =
/proc/meminfo   increases by the number of bytes accessed.And after =
closing the application also the memory used is not released and  it =
goes to cached memory .
We are using 2.4.20 kernel in our device.We are not sure whether the =
/proc/meminfo shows the erroneous output or the file read/write routines =
got any problem.
Can anyone suggest me some idea how to trace out the problem.

I have given the sample code  below.
The memory consumption grows and it takes about 10 MB memory space =
[10000 * 1024] when i run the below given code.
When i look into /proc/meminfo the free memory is reduced by 10 MB and =
Cache Memory & Used memory is increased by 10 mb after running this =
application.
When i run the below given code first time the memory grows,when  i run =
succesively it doesn't grow again , may be using the already taken =
memory.



int main()
{

FILE *fp;

unsigned long int i;
unsigned char data[1024];

fp=3Dfopen("test.txt","r");
for(i=3D0;i<10000;i++)
{

      fread(data,1024,1,fp);
}
fclose(fp);
}


With Thanks & Regards,
Deepak S

------=_NextPart_000_02C8_01C54F11.A1790B30
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1479" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hi All,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am &nbsp;facing an issue in file=20
operation,</FONT><FONT face=3DArial size=3D2>&nbsp;when we read/write =
continuously=20
to&nbsp; a large file in our&nbsp; ppc 405 based device , memory usage =
shown in=20
/proc/meminfo&nbsp; &nbsp;increases by the number of bytes =
accessed.</FONT><FONT=20
face=3DArial size=3D2>And after closing the application also the memory =
used is not=20
released and &nbsp;it goes to cached memory .</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>We are using 2.4.20 kernel in our =
device.We are not=20
sure whether the /proc/meminfo shows the erroneous output or the file =
read/write=20
routines got any problem.</FONT></DIV>
<DIV>Can anyone suggest me some idea how to trace out the problem.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have given the sample code&nbsp; below.</DIV>
<DIV>The memory consumption grows and it takes about 10 MB memory space =
[10000 *=20
1024] when i run the below given code.</DIV>
<DIV>When i look into /proc/meminfo the free memory is reduced by 10 MB =
and=20
Cache Memory &amp; Used memory is increased by 10 mb after running this=20
application.</DIV>
<DIV>When i run the below given code first time the memory =
grows,when&nbsp; i=20
run succesively it doesn't grow again , may be using the already taken=20
memory.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>int main()<BR>{</DIV>
<DIV>&nbsp;</DIV>
<DIV>FILE *fp;<BR></DIV>
<DIV>unsigned long int i;<BR>unsigned char data[1024];</DIV>
<DIV>&nbsp;</DIV>
<DIV>fp=3Dfopen("test.txt","r");<BR>for(i=3D0;i&lt;10000;i++)<BR>{</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
fread(data,1024,1,fp);<BR>}<BR>fclose(fp);<BR>}</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>With Thanks &amp; Regards,</DIV>
<DIV>Deepak S</DIV>
<DIV><FONT face=3DArial=20
size=3D2></FONT>&nbsp;</DIV></FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_02C8_01C54F11.A1790B30--

--=-bd-boundary-Ev8yDkhKB5bIMy7K
Content-Type: text/plain; name="BitDefender.txt"
Content-Disposition: inline; filename="BitDefender.txt"


-- 
This message contains information from GDA Technologies LTD  and affiliates, and is intended for the sole use of the individual and entity to whom it is addressed. It may contain information, including any attachments, that is privileged, confidential and exempt from disclosure under applicable law. If you are not the intended addressee, nor authorized to receive for the intended addressee, you are hereby notified that you may not use, copy, disclose or distribute to anyone the message or any information contained in the message. If you have received this electronic transmission in error, please notify the sender immediately by a "reply to sender only" message and destroy all electronic and hard copies of the communication, including attachments.
This message was scanned for spam and viruses by BitDefender.

--=-bd-boundary-Ev8yDkhKB5bIMy7K--
