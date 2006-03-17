Return-Path: <iluri@fagorautomation.es>
Received: from sollube.sarenet.es (mx1.sarenet.es [194.30.0.37])
	by ozlabs.org (Postfix) with ESMTP id 9A649679E0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 22:35:08 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by sollube.sarenet.es (Postfix) with ESMTP id 03D1D36F62
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 12:35:03 +0100 (CET)
Message-ID: <441A9FC8.3020205@fagorautomation.es>
Date: Fri, 17 Mar 2006 12:38:48 +0100
From: Igor Luri <iluri@fagorautomation.es>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: mpc5xxx keyboard BUG found
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We have an MPC5200LiteB board with a Microsoft USB keyboard atached and 
we have realized that some keys don't work properly, like up, down, lef 
and right arrows, PageUp, PageDown etc.

We have found that when those keys are pressed, first it sends a special 
scancode 0xe0 and then pressed key scancode.

Modifiying mpc5xxx_translate function to ignore the first scancode
 

                 // special prefix scancodes..
                  if (scancode == 0xe0 || scancode == 0xe1) {
                        return 0;
                  } 

our keyboard works well. Other cpus ignorates this special scancode or  
it evaluates.

Now, mpc5xxx_translate looks like this:

int mpc5xxx_translate(unsigned char scancode, unsigned char *keycode,
               char raw_mode)
{
    
  // special prefix scancodes..
  if (scancode == 0xe0 || scancode == 0xe1) {
        return 0;
  }  

  //0xFF is sent by a few keyboards, ignore it. 0x00 is error
  if (scancode == 0x00 || scancode == 0xff) {
    return 0;
  }
  *keycode = scancode;
  return 1;
}
