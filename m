Return-Path: <eberhard.stoll@berghof.com>
Received: from mail92.messagelabs.com (mail92.messagelabs.com [194.106.220.51])
	by ozlabs.org (Postfix) with SMTP id 2D4CE679EB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 23:43:11 +1000 (EST)
Message-ID: <4469D55E.50105@berghof.com>
Date: Tue, 16 May 2006 15:36:30 +0200
From: Eberhard Stoll <eberhard.stoll@berghof.com>
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: "Need help to configure DNS on the Embedded system"
References: <34616.61.95.208.2.1147781429.squirrel@61.95.208.2>
In-Reply-To: <34616.61.95.208.2.1147781429.squirrel@61.95.208.2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Which C library do you use?
Did you setup /etc/hosts.conf correctly?
It should look like this:
---
   order hosts, bind
   multi on
---

If you use glibc you shold add 'dns' to /etc/nsswitch.conf file like that:
---
   ...
   hosts: files dns
   networks: files dns
   ...
---
This will tell glibc to look for hostnames in /etc/hosts and via dns.
Additionally glibc needs the two libraries libresolv and libnss_dns for
this setting to work!

Good luck
Eberhard
