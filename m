Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6.jnb1.host-h.net [196.22.132.6])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41A60B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 20:09:39 +1000 (EST)
Received: from 41-134-83-187.dsl.mweb.co.za ([41.134.83.187]
	helo=[172.16.63.184]) by www6.jnb1.host-h.net with esmtpa (Exim 4.72)
	(envelope-from <phenning@vastech.co.za>) id 1QgwNn-0002rF-3b
	for linuxppc-dev@lists.ozlabs.org; Wed, 13 Jul 2011 12:09:31 +0200
Message-ID: <4E1D6ED8.10300@vastech.co.za>
Date: Wed, 13 Jul 2011 12:09:28 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Soved problem receiving udp broadcasts
References: <4E1D513F.9030405@vastech.co.za>
In-Reply-To: <4E1D513F.9030405@vastech.co.za>
Content-Type: text/html; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    <font face="Arial"></font>Hi<br>
    <br>
    The problem was that "reverse-path filtering" was enabled. after
    disabling reverse-path filtering I could receive broadcasts as
    expected.<br>
    <br>
    As a side note - interface does not need to be in promiscuous mode<br>
    <br>
    cheers pieter<br>
    <br>
    On 13/07/2011 10:03, Pieter wrote:
    <blockquote cite="mid:4E1D513F.9030405@vastech.co.za" type="cite">Hi
      All
      <br>
      <br>
      Im running Linux 2.6.32.14 on an embedded&nbsp; MPC4858.
      <br>
      One of the Application (CLI) must reciece a UDP broadcast packet.
      <br>
      <br>
      The problem is that I only receive packets broadcast from within
      the same subnet&nbsp; (192.168.0.x)&nbsp; even though the broadcast app
      sends the broadcast to&nbsp; 255.255.255.255.
      <br>
      <br>
      when i run tcpdump on the embedded machine it shows both
      broadcasts from the same subnet well as different subsets: as
      shown below:
      <br>
      <br>
      &nbsp;&nbsp;&nbsp; SDH-0A000221&gt; /tmp/tcpdump port 23 or port 33334
      <br>
      &nbsp;&nbsp;&nbsp; tcpdump: verbose output suppressed, use -v or -vv for full
      protocol decode
      <br>
      &nbsp;&nbsp;&nbsp; listening on eth0, link-type EN10MB (Ethernet), capture size
      65535 bytes
      <br>
      (1)&nbsp;&nbsp;&nbsp; 07:48:35.787826 IP 172.16.63.184.cli &gt;
      255.255.255.255.cli: UDP, length 58
      <br>
      (2)&nbsp;&nbsp; 07:48:43.832539 IP 192.168.0.1.cli &gt; 255.255.255.255.cli:
      UDP, length 60
      <br>
      (3)&nbsp;&nbsp;&nbsp; 07:48:43.840627 IP 192.168.0.254.cli &gt; 192.168.0.1.cli:
      UDP, length 112
      <br>
      <br>
      The embedded machine is configured with:
      <br>
      ip 192.168.0.254
      <br>
      mask 255.255.0.0
      <br>
      <br>
      (1) is a broadcast from a different subnet
      <br>
      (2) is broadcast from within same subnet
      <br>
      (3) the imbeded applications reply to the broadcast from same
      subnet
      <br>
      <br>
      <br>
      The service has been delared in&nbsp; "etc/xinetd.d/cli" as follows:
      <br>
      service cli
      <br>
      {
      <br>
      &nbsp;&nbsp;&nbsp; socket_type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = dgram
      <br>
      &nbsp;&nbsp;&nbsp; protocol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = udp
      <br>
      &nbsp;&nbsp;&nbsp; port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 23
      <br>
      &nbsp;&nbsp;&nbsp; wait&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = yes
      <br>
      &nbsp;&nbsp;&nbsp; user&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = root
      <br>
      &nbsp;&nbsp;&nbsp; server&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = /usr/vastech/in.cli
      <br>
      &nbsp;&nbsp;&nbsp; disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = no
      <br>
      &nbsp;&nbsp;&nbsp; cps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 10 5
      <br>
      &nbsp;&nbsp;&nbsp; flags&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = IPv4
      <br>
      }
      <br>
      <br>
      and the port assigned in "/etc/xinetd.d/services" as follows (port
      23 for back comparability with older products)
      <br>
      <br>
      &nbsp;&nbsp;&nbsp; #telnet&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23/udp
      <br>
      &nbsp;&nbsp;&nbsp; cli&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23/udp
      <br>
      &nbsp;&nbsp;&nbsp; cli&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33334/udp
      <br>
      <br>
      Is there something basic that I have overlooked ? should the
      interface be set and left in
      <br>
      promiscuous mode to do what I require?
      <br>
      <br>
      thanks pieter
      <br>
      <br>
    </blockquote>
    <br>
    <pre class="moz-signature" cols="72">-- 
VASTech PTY (LTD)
021 880 9807</pre>
  </body>
</html>
