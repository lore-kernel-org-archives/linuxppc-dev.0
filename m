Subject: RE: How?
From: Craig Hollabaugh <craig@hollabaugh.com>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Date: 15 May 2003 08:03:48 -0600
Message-Id: <1053007429.481.6.camel@ch>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rakesh,


Your interrupt routine can send a signal to your user space process.

Here's what I've used

void sendSignal(void)
{
        struct task_struct *p;
        if ( pid ) {

/*
        for_each_task(p) {
                if (p->pid == pid) {
                        send_sig(SIGIO,p,1);
                        break;
                }
        }
*/

/* or better yet */

        if (p = find_task_by_pid(pid)) send_sig(SIGIO,p,1);
        /* from page 83 in ulk */
        }
}

ulk is Understanding The Linux Kernel.

Craig


--
___________________________________________________________
Dr. Craig Hollabaugh                   craig@hollabaugh.com
Author of Embedded Linux

P.O. Box 1405
Ouray, CO 81427-1405        See my "kitchen sink" resume at
970 325 4810 home            www.hollabaugh.com/resume.html
970 325 0509 office


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
