Return-Path: <Daniele.Bosi@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4830FB7D1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 May 2010 01:40:31 +1000 (EST)
Received: from mail.mta.it (mail.mta.it [91.143.207.180])
	by rly05a.srv.mailcontrol.com (MailControl) with ESMTP id
	o4RFeK9B030540
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2010 16:40:24 +0100
From: Bosi Daniele <Daniele.Bosi@mta.it>
To: "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 27 May 2010 17:39:35 +0200
Subject: halt the system without any broadcast message on the console
Message-ID: <531B6536C9F737458807DF75064873C8BE62B40C49@mta-digimail.MTA.INT>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,
on the embedded system I'm working (mpc5121e, linux kernel 2.6.24.6) when I=
 type the command "halt" on the console I see a broadcast message sent to a=
ll the users like this:

" Broadcast message from root (console) (Thu May 27 09:04:41 2010):

The system is going down for system halt NOW!"

I'd like to avoid this message on the console I'm using because at producti=
on time this has to be a simple serial port for external peripheral connect=
ion. (to do this on the command line we'll leave empty the "console" field)=
.

The only way I found to avoid the broadcast message is the command "telinit=
 0" . In this way no one calls the "shutdown" command that is the one which=
 send the broadcast message.
I did also some tests with the shutdown parameters but none of them erase t=
he broadcast message.

So my questions are:
Does the command  "telinit 0" is safe in order to halt the machine?
Does the command  "telinit 6" is safe in order to reboot the machine?
Are there others commands to do the same work without the broadcast message=
?


Thanks
Daniele Bosi
