Return-Path: <stevan@iritel.com>
Received: from iritel.iritel.bg.ac.rs (iritel.iritel.bg.ac.rs [193.203.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A8F9B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 00:21:56 +1000 (EST)
Received: from iritel.iritel.bg.ac.rs (root@localhost)
	by iritel.iritel.bg.ac.rs (8.13.1/8.13.1) with SMTP id o5TEGEJm011732
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jun 2010 16:16:19 +0200
Received: from [193.203.19.118] (stevan [193.203.19.118])
	by iritel.iritel.bg.ac.rs (8.13.1/8.13.1) with ESMTP id o5TEGD86011724
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jun 2010 16:16:13 +0200
Subject: ftp login problem using wu-ftpd
From: Stevan Ignjatovic <stevan@iritel.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain
Date: Tue, 29 Jun 2010 16:16:31 +0200
Message-Id: <1277820991.4257.18.camel@stevan>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I ported Linux-2.6.30-rc8 on my custom mpc885 board. The filesystem I am
using is jffs2 which I created from
eldk-4.2/ppc_8xx/images/ramdisk_image.gz. Linux boots fine and I can
telnet to the board but I cannot ftp:

# ftp 10.8.1.5
Connected to 10.8.1.5.
220 10.8.1.5 FTP server (Version wu-2.6.2(1) Wed Apr 2 09:10:49 MEST
2008) ready.
530 Please login with USER and PASS.
530 Please login with USER and PASS.
KERBEROS_V4 rejected as an authentication type
Name (10.8.1.5:root): root

Here ftp connection hangs. Do I have to create another user (beside
root) in order to make ftp connection? Earlier, when I was using 2.4
linux I didn't have problems with ftp connection as root.


/etc/ftpaccess:
class   all   real,guest,anonymous  *

email root@localhost

loginfails 5

readme  README*    login
readme  README*    cwd=*

message /welcome.msg            login
message .message                cwd=*

compress        yes             all
tar             yes             all
chmod		no		guest,anonymous
delete		no		guest,anonymous
overwrite	no		guest,anonymous
rename		no		guest,anonymous

log transfers anonymous,real inbound,outbound

shutdown /etc/shutmsg

passwd-check rfc822 warn



/etc/xinetd.d/wu-ftpd:
# default: on
# description: The wu-ftpd FTP server serves FTP connections. It uses \
#	normal, unencrypted usernames and passwords for authentication.
service ftp
{
	socket_type		= stream
	wait			= no
	user			= root
	server			= /usr/sbin/in.ftpd
	server_args		= -l -a
	log_on_success		+= DURATION USERID
	log_on_failure		+= USERID
	nice			= 10
	disable			= no
}


/etc/pam.d/ftp:
#%PAM-1.0
auth    include	system-auth
auth       required	/lib/security/pam_listfile.so item=user sense=deny
file=/etc/ftpusers onerr=succeed
auth       required	/lib/security/pam_shells.so
account include	system-auth
session include	system-auth

Thanks in advance.
